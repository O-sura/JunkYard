#!/bin/bash

#EXT_HELPERS


#Generate the md5 hash for a given file
getmd5() {
    if [ -z "$1" ]; then
        echo "Usage: calculate_md5 <filename>"
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found!"
        return 1
    fi

    md5sum "$1" | awk '{print $1}'
}

# Function to convert little-endian hex to big-endian
letobe() {
  if [ -z "$1" ]; then
    echo "Usage: letobe <little-endian-hex-string>"
    return 1
  fi

  input=$(echo "$1" | tr -d ' ' | sed 's/^0x//')

  if [ $(( ${#input} % 2 )) -ne 0 ]; then
    echo "Error: Invalid hex string length."
    return 1
  fi

  big_endian=$(echo "$input" | fold -w2 | tac | tr -d '\n')
  # Remove leading zeros
  #big_endian=$(echo "$big_endian" | sed 's/^0*//')
  echo "$big_endian"  # Only return the hex string
}


# Function to convert hex to decimal
hextodec() {
  if [ -z "$1" ]; then
    echo "Usage: hextodec <hex-value>"
    return 1
  fi

  input=$(echo "$1" | tr -d ' ' | sed 's/^0x//')

  if ! echo "$input" | grep -qE '^[0-9A-Fa-f]+$'; then
    echo "Error: Invalid hex string."
    return 1
  fi

  decimal=$(( 0x$input ))
  echo "$decimal"  
}


#Print Partition Table Data
printPartitionTable() {
    if [ -z "$1" ]; then
        echo "Usage: getPartitionTable <disk_image.dd>"
        return 1
    fi

    local disk_image="$1"

    # Extract the partition table (64B) from MBR (offset 0x1BE)
    partition_table=$(dd if="$disk_image" bs=1 skip=446 count=64 2>/dev/null | xxd -p -c16)

    if [ -z "$partition_table" ]; then
        echo "Failed to extract partition table."
        return 1
    fi

    echo "Partition Table (Raw Hex):"
    echo "$partition_table"

    # Parse 4 partition entries (16B each)
    for i in {0..3}; do
        entry=$(echo "$partition_table" | sed -n "$((i+1))p")
        
        bootable_flag=$(echo "$entry" | cut -c1-2)
        partition_type=$(echo "$entry" | cut -c9-10)
        lba_start=$(hextodec "$(letobe "$(echo "$entry" | cut -c17-24)")")
        num_sectors=$(hextodec "$(letobe "$(echo "$entry" | cut -c25-32)")")

        echo "-----------------------------"
        echo "Partition $((i+1))"
        echo "Bootable: $( [ "$bootable_flag" == "80" ] && echo "Yes" || echo "No" )"
        echo "Partition Type: 0x$partition_type"
        echo "LBA Start: 0x$lba_start"
        echo "Number of Sectors: 0x$num_sectors"
    done
}




# Function to extract and parse partition table from a disk image file
getPartitionTable() {
    if [ -z "$1" ]; then
        echo "Usage: getPartitionTable <disk_image.dd>"
        return 1
    fi

    local disk_image="$1"

    # Extract the partition table (64B) from MBR (offset 0x1BE)
    partition_table=$(dd if="$disk_image" bs=1 skip=446 count=64 2>/dev/null | xxd -p -c16)

    if [ -z "$partition_table" ]; then
        echo "Failed to extract partition table."
        return 1
    fi

    echo "Partition Table (Raw Hex):"
    echo "$partition_table"

    partitions=()
    for i in {0..3}; do
        entry=$(echo "$partition_table" | sed -n "$((i+1))p")

        bootable_flag=$(echo "$entry" | cut -c1-2)
        partition_type=$(echo "$entry" | cut -c9-10)

        lba_start_hex=$(echo "$entry" | cut -c17-24)
        num_sectors_hex=$(echo "$entry" | cut -c25-32)

        lba_start=$(letobe "$lba_start_hex")
        num_sectors=$(letobe "$num_sectors_hex")

        # Convert hex to decimal safely
        if [[ "$lba_start" =~ ^[0-9a-fA-F]+$ ]]; then
            lba_start_dec=$((16#$lba_start))
        else
            lba_start_dec=0
        fi

        if [[ "$num_sectors" =~ ^[0-9a-fA-F]+$ ]]; then
            num_sectors_dec=$((16#$num_sectors))
        else
            num_sectors_dec=0
        fi

        partitions+=("$lba_start_dec,$num_sectors_dec,$partition_type")

        echo "-----------------------------"
        echo "Partition $((i+1))"
        echo "Bootable: $( [ "$bootable_flag" == "80" ] && echo "Yes" || echo "No" )"
        echo "Partition Type: 0x$partition_type"
        echo "LBA Start: $lba_start_dec"
        echo "Number of Sectors: $num_sectors_dec"
    done

    extractPartitions "$disk_image" "${partitions[@]}"
}


# Function to extract partitions and save them as separate files
extractPartitions() {
    local disk_image="$1"
    shift # Remove disk image from argument list

    local partition_num=1
    for partition in "$@"; do
        IFS=',' read -r lba_start num_sectors partition_type <<< "$partition"

        if [ "$num_sectors" -eq 0 ]; then
            echo "Skipping empty partition $partition_num"
        else
            output_file="partition_${partition_num}_type_0x${partition_type}.dd"
            echo "Extracting Partition $partition_num -> $output_file"

            dd if="$disk_image" of="$output_file" bs=512 skip="$lba_start" count="$num_sectors" status=progress

            echo "Partition $partition_num extracted successfully."
        fi

        ((partition_num++))
    done
}

# Function to Extract FAT Boot Sector Structure
extractFatBoot() {
    if [ -z "$1" ]; then
        echo "Usage: extractFatBoot <partition.dd>"
        return 1
    fi
    
    local disk_img="$1"
    
    # Extract the boot sector
    echo "-> Extracting the boot..."
    dd if="$disk_img" of="fat_boot.dd" bs=1 count=512
    echo "-> Boot Sector Extracted Successfully."
}


# Function to Print FAT Boot Sector Structure
printFatBoot() {
    if [ -z "$1" ]; then
        echo "Usage: printFatBoot <partition.dd>"
        return 1
    fi
    
    local boot_sector="$1"
    
    # Print the boot sector info
    printf "-> Boot Sector (Hex):\n\n"
    
    local boot_sector_hex
    boot_sector_hex=$(xxd -p -c16 "$boot_sector")
    #echo "$boot_sector_hex"
    
    # Extract fields based on offsets
    bs_code_addr=${boot_sector_hex:0:6}  # Offset 0x00, Length 3
    OEM_name=$(echo "${boot_sector_hex:6:16}" | xxd -r -p)  # Offset 0x03, Length 8
    bytes_per_sector_le=${boot_sector_hex:22:4}  # Offset 0x0B, Length 2
    sectors_per_cluster=${boot_sector_hex:26:2}  # Offset 0x0D, Length 1
    reserved_sectors_le=${boot_sector_hex:28:4}  # Offset 0x0E, Length 2
    num_of_FATs=${boot_sector_hex:32:2}  # Offset 0x10, Length 1
    max_root_entries_le=${boot_sector_hex:34:4}  # Offset 0x11, Length 2
    total_sectors_le=${boot_sector_hex:38:4}  # Offset 0x13, Length 2
    media_type=${boot_sector_hex:42:2}  # Offset 0x15, Length 1
    sectors_per_FAT_le=${boot_sector_hex:44:4}  # Offset 0x16, Length 2

    # Convert Little-Endian Values
    bytes_per_sector=$(hextodec "$(letobe "$bytes_per_sector_le")")
    reserved_sectors=$(hextodec "$(letobe "$reserved_sectors_le")")
    max_root_entries=$(hextodec "$(letobe "$max_root_entries_le")")
    total_sectors=$(hextodec "$(letobe "$total_sectors_le")")
    sectors_per_FAT=$(hextodec "$(letobe "$sectors_per_FAT_le")")

    # Print Extracted Fields
    echo "OEM Name: $OEM_name"
    echo "Bytes per Sector: $bytes_per_sector"
    echo "Sectors per Cluster: $(hextodec "$sectors_per_cluster")"
    echo "Reserved Sectors: $reserved_sectors"
    echo "No. of FATS: $num_of_FATs"
    #echo "Number of FATs: $(hextodec "$num_of_FATs")"
    echo "Max Root Directory Entries: $max_root_entries"
    echo "Total Number of Sectors: $total_sectors"
    echo "Media Type: $media_type"
    echo "Sectors per FAT: $sectors_per_FAT"
    
}


#-----------------------------------------------------------------------

#NTFS_HELPERS

extract_mft_entries() {
    local input_file="partition_2_type_ntfs.dd"
    local record_size=1024  # Each MFT record is 1024 bytes
    local start_offset=16384  # Starting offset of the 0th entry
    local total_records=76  # Total number of MFT records

    for ((i=0; i<total_records; i++)); do
        local offset=$((start_offset + (i * record_size)))
        dd if="$input_file" of="mft-entry-$i.dd" bs=1 skip="$offset" count="$record_size" status=none
        echo "Extracted MFT entry $i at offset $offset"
    done
}


hexadd() {
    local hex1=$1
    local hex2=$2

    # Convert hex to decimal, add them, then convert back to hex
    local sum=$(printf "%X\n" $(( 0x$hex1 + 0x$hex2 )))

    echo "$sum"
}


analyze_mft_entries() {
    output_file="mft_analysis.txt"
    image_file="partition_2_type_ntfs.dd"


    for inode in $(seq 0 68); do
        echo "Analyzing inode $inode..." 
        istat "$image_file" "$inode" 
        echo "---------------------------------"
    done

    echo "Analysis complete."
}

amft() {
    output_file="mft_analysis.txt"
    image_file="partition_2_type_ntfs.dd"


    for inode in $(seq 0 75); do
        echo "Analyzing inode $inode..." 
        istat "$image_file" "$inode" 
        echo "---------------------------------"
    done

    echo "Analysis complete."
}


analyze_mft_entry() {
    # Check if the MFT entry file is provided
    if [ -z "$1" ]; then
        echo "Usage: analyze_mft_entry <mft-entry-file>"
        return 1
    fi

    # Input MFT entry file
    MFT_ENTRY_FILE="$1"

    # Check if the file exists
    if [ ! -f "$MFT_ENTRY_FILE" ]; then
        echo "Error: File '$MFT_ENTRY_FILE' not found."
        return 1
    fi

    # Read the hex dump of the MFT entry
    HEX_DUMP=$(xxd -p -c 256 "$MFT_ENTRY_FILE" | tr -d '\n')

    # Function to extract bytes from hex dump
    extract_bytes() {
        OFFSET=$1
        LENGTH=$2
        echo "${HEX_DUMP:$((OFFSET*2)):$((LENGTH*2))}"
    }

    # Extract fields based on offsets
    ALLOCATION_STATUS=$(extract_bytes 0x16 2)          # Offset 0x16, 2 bytes
    LOGICAL_FILE_SIZE=$(extract_bytes 0x18 4)          # Offset 0x18, 4 bytes
    OFFSET_TO_FIRST_ATTRIBUTE=$(extract_bytes 0x14 2)  # Offset 0x14, 2 bytes

    # Convert little-endian to big-endian using letobe
    ALLOCATION_STATUS_BE=$(letobe "$ALLOCATION_STATUS")
    LOGICAL_FILE_SIZE_BE=$(letobe "$LOGICAL_FILE_SIZE")
    OFFSET_TO_FIRST_ATTRIBUTE_BE=$(letobe "$OFFSET_TO_FIRST_ATTRIBUTE")

    # Convert hex to decimal for logical file size and offset
    LOGICAL_FILE_SIZE_DEC=$(printf "%d" "0x$LOGICAL_FILE_SIZE_BE")
    OFFSET_TO_FIRST_ATTRIBUTE_DEC=$(printf "%d" "0x$OFFSET_TO_FIRST_ATTRIBUTE_BE")

    # Determine allocation status description
    case "$ALLOCATION_STATUS_BE" in
        "0000") ALLOCATION_DESC="File, Deleted" ;;
        "0001") ALLOCATION_DESC="File, Allocated" ;;
        "0010") ALLOCATION_DESC="Folder, Deleted" ;;
        "0011") ALLOCATION_DESC="Folder, Allocated" ;;
        *) ALLOCATION_DESC="Unknown" ;;
    esac

    # Print the results
    echo "Allocation Status: 0x$ALLOCATION_STATUS_BE ($ALLOCATION_DESC)"
    echo "Logical File Size: 0x$LOGICAL_FILE_SIZE_BE ($LOGICAL_FILE_SIZE_DEC bytes)"
    echo "Offset to First Attribute: 0x$OFFSET_TO_FIRST_ATTRIBUTE_BE ($OFFSET_TO_FIRST_ATTRIBUTE_DEC bytes)"
    
    # Call the analyze_mft_attributes function
    echo "\n\nAnalyzing MFT attributes:"
    analyze_mft_attributes "$HEX_DUMP" "$OFFSET_TO_FIRST_ATTRIBUTE_BE"
}


# Example usage of the function
# Uncomment the line below and replace "mft-entry_0.dd" with your file
# analyze_mft_entry "mft-entry_0.dd"


# Function to analyze MFT attributes
analyze_mft_attributes() {
    # Check if HEX_DUMP and offset are provided
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: analyze_mft_attributes <hex-dump> <offset-to-first-attribute>"
        return 1
    fi

    HEX_DUMP="$1"
    OFFSET_TO_FIRST_ATTRIBUTE="$2"

    # Initialize current offset
    CURRENT_OFFSET="$OFFSET_TO_FIRST_ATTRIBUTE"

    # Loop through attributes until the end marker is found
    while true; do
        # Extract attribute type identifier (4 bytes)
        ATTRIBUTE_TYPE=$(echo "${HEX_DUMP:$(( 0x$CURRENT_OFFSET * 2 )):8}")

        # Check for end of attributes (0xFFFFFFFF indicates end)
        if [ "$ATTRIBUTE_TYPE" == "ffffffff" ]; then
            echo "End of attributes reached.\n\n"
            break
        fi

        # Extract attribute size (4 bytes at offset 0x04 in the attribute header)
        ATTRIBUTE_SIZE=$(echo "${HEX_DUMP:$(( (0x$CURRENT_OFFSET + 0x04) * 2 )):8}")
        ATTRIBUTE_SIZE=$(letobe "$ATTRIBUTE_SIZE")
        echo "Attribute Size in Bytes: $(hextodec "$ATTRIBUTE_SIZE") Bytes"

        # Extract non-resident flag (1 byte at offset 0x08 in the attribute header)
        NON_RESIDENT_FLAG=$(echo "${HEX_DUMP:$(( (0x$CURRENT_OFFSET + 0x08) * 2 )):2}")

        # Determine if the attribute is resident or non-resident
        if [ "$NON_RESIDENT_FLAG" == "00" ]; then
	    RESIDENT_STATUS="Resident"
	    
	    # Extract offset to the attribute stream (2 bytes at offset 0x14 in the resident header)
	    OFFSET_TO_ATTR_STREAM=$(echo "${HEX_DUMP:$(( (0x$CURRENT_OFFSET + 0x14) * 2 )):4}")
	    OFFSET_TO_ATTR_STREAM=$(letobe "$OFFSET_TO_ATTR_STREAM")
	    echo "Offset to Attribute Stream: 0x$OFFSET_TO_ATTR_STREAM"

	elif [ "$NON_RESIDENT_FLAG" == "01" ]; then
	    RESIDENT_STATUS="Non-Resident"

	    # Extract Logical Size (8 bytes at offset 0x30 in the non-resident header)
	    LOGICAL_SIZE=$(echo "${HEX_DUMP:$(( (0x$CURRENT_OFFSET + 0x30) * 2 )):16}")
	    LOGICAL_SIZE=$(letobe "$LOGICAL_SIZE")
	    echo "Logical Size: $(hextodec "$LOGICAL_SIZE") Bytes"

	    # Extract Offset to Run List (2 bytes at offset 0x20 in the non-resident header)
	    OFFSET_TO_RUN_LIST=$(echo "${HEX_DUMP:$(( (0x$CURRENT_OFFSET + 0x20) * 2 )):4}")
	    OFFSET_TO_RUN_LIST=$(letobe "$OFFSET_TO_RUN_LIST")
	    echo "Offset to Run List: 0x$OFFSET_TO_RUN_LIST"
	    
	    # Extract and print the Run List
	    echo "\n>>>>>>>>>>>>>>>>>>>>"
            echo "Extracting Run List:"
            extract_run_list "$HEX_DUMP" "$(hexadd "$CURRENT_OFFSET" "$OFFSET_TO_RUN_LIST")"       

	else
	    RESIDENT_STATUS="Unknown"
	fi
	
        # Map attribute type identifier to its description
        case "$ATTRIBUTE_TYPE" in
	    "10000000") ATTRIBUTE_DESC="\$Standard_Information" ;;
	    "20000000") ATTRIBUTE_DESC="\$Attribute_List" ;;
	    "30000000") ATTRIBUTE_DESC="\$File_Name" ;;
	    "40000000") ATTRIBUTE_DESC="\$Object_ID" ;;
	    "50000000") ATTRIBUTE_DESC="\$Security_Descriptor" ;;
	    "60000000") ATTRIBUTE_DESC="\$Volume_Name" ;;
	    "70000000") ATTRIBUTE_DESC="\$Volume_Information" ;;
	    "80000000") ATTRIBUTE_DESC="\$Data" ;;
	    "90000000") ATTRIBUTE_DESC="\$Index_Root" ;;
	    "a0000000") ATTRIBUTE_DESC="\$Index_Allocation" ;;
	    "b0000000") ATTRIBUTE_DESC="\$Index_Bitmap" ;;
	    *) ATTRIBUTE_DESC="Unknown" ;;
	esac
	
	if [ "$ATTRIBUTE_DESC" == "\$File_Name" ]; then
	    #Get the offset to the filename attribute stream
	    FILENAME_ATTR_OFFSET=$(hexadd "$CURRENT_OFFSET" "$OFFSET_TO_ATTR_STREAM")
	    
	    # Extract the $MFT record no of the parent directory
	    PARENT_MFT_ENTRY_HEX=$(echo "${HEX_DUMP:$(( (0x$FILENAME_ATTR_OFFSET) * 2 )):12}")
	    PARENT_MFT_ENTRY=$(printf "%d" "0x$(letobe "$PARENT_MFT_ENTRY_HEX")")
	    echo "Parent MFT Entry: $PARENT_MFT_ENTRY"
	    
	    # Extract the file name character count (1 byte at offset 0x40 in the $File_Name attribute)
	    FILE_NAME_CHAR_COUNT_HEX=$(echo "${HEX_DUMP:$(( (0x$FILENAME_ATTR_OFFSET + 0x40) * 2 )):2}")
	    FILE_NAME_CHAR_COUNT=$(printf "%d" "0x$FILE_NAME_CHAR_COUNT_HEX")
	    echo "File Name Character Count: $FILE_NAME_CHAR_COUNT_HEX"

	    # Calculate the length of the file name in bytes (each Unicode character is 2 bytes)
	    FILE_NAME_LENGTH=$((FILE_NAME_CHAR_COUNT * 2))

	    # Extract the file name (Unicode string starting at offset 0x42 in the $File_Name attribute)
	    FILE_NAME_HEX=$(echo "${HEX_DUMP:$(( (0x$FILENAME_ATTR_OFFSET+ 0x42) * 2 )):$((FILE_NAME_LENGTH * 2))}")
	    echo "File name hex: $FILE_NAME_HEX"
	    # Convert the hex file name to a readable string
	    FILE_NAME=$(echo "$FILE_NAME_HEX" | xxd -r -p)
	    echo "File Name: $FILE_NAME"
	fi

        # Print the attribute details
        echo "Attribute Type: 0x$ATTRIBUTE_TYPE ($ATTRIBUTE_DESC)"
        echo "Resident Status: $RESIDENT_STATUS"
        echo "-----------------------------"

        # Calculate the next offset by adding the current offset and attribute size
        NEXT_OFFSET=$(hexadd "$CURRENT_OFFSET" "$ATTRIBUTE_SIZE")
        echo "Current Offset: 0x$NEXT_OFFSET"

        # Update the current offset
        CURRENT_OFFSET="$NEXT_OFFSET"
    done
}

# Function to extract and print run lengths and cluster offsets
extract_run_list() {
    # Check if HEX_DUMP and offset are provided
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: extract_run_list <hex-dump> <offset-to-run-list>"
        return 1
    fi

    HEX_DUMP="$1"
    OFFSET_TO_RUN_LIST="$2"

    # Initialize current offset
    OFFSET="$OFFSET_TO_RUN_LIST"

    # Loop through the Run List until a 00 byte is encountered
    while true; do
        # Extract the first byte (control byte)
        CONTROL_BYTE=$(echo "${HEX_DUMP:$(( 0x$OFFSET * 2 )):2}")
        
        # Check if the control byte is 00 (end of Run List)
        if [ "$CONTROL_BYTE" == "00" ]; then
            echo "End of Run List reached."
            echo "<<<<<<<<<<<<<<<<<<<<<<<\n"
            break
        fi

        # Split the control byte into nibbles
        HIGH_NIBBLE=$(echo "$CONTROL_BYTE" | cut -c1)
        LOW_NIBBLE=$(echo "$CONTROL_BYTE" | cut -c2)

        # Convert nibbles to decimal
        RUN_LENGTH_BYTES=$(printf "%d" "0x$LOW_NIBBLE")
        CLUSTER_OFFSET_BYTES=$(printf "%d" "0x$HIGH_NIBBLE")

        # Move to the next byte
        OFFSET=$(hexadd "$OFFSET" "1")

        # Extract Run Length (X bytes)
        RUN_LENGTH_HEX=$(echo "${HEX_DUMP:$(( 0x$OFFSET * 2 )):$((RUN_LENGTH_BYTES * 2))}")
        RUN_LENGTH_HEX=$(letobe "$RUN_LENGTH_HEX")
        RUN_LENGTH=$(printf "%d" "0x$RUN_LENGTH_HEX")

        # Move to the next byte after Run Length
        OFFSET=$(hexadd "$OFFSET" "$RUN_LENGTH_BYTES")

        # Extract Cluster Offset (Y bytes)
        CLUSTER_OFFSET_HEX=$(echo "${HEX_DUMP:$(( 0x$OFFSET * 2 )):$((CLUSTER_OFFSET_BYTES * 2))}")
        CLUSTER_OFFSET_HEX=$(letobe "$CLUSTER_OFFSET_HEX")
        CLUSTER_OFFSET=$(printf "%d" "0x$CLUSTER_OFFSET_HEX")

        # Move to the next byte after Cluster Offset
        OFFSET=$(hexadd "$OFFSET" "$CLUSTER_OFFSET_BYTES")

        # Print the Run Length and Cluster Offset
        echo "Run Length: $RUN_LENGTH clusters"
        echo "Cluster Offset: $CLUSTER_OFFSET clusters"
    
    done
}


analyze_all_mft_entries() {
    for i in {0..68}; do
        entry_name="mft-entry-$i.dd"
        echo "Processing: $entry_name"
        analyze_mft_entry "$entry_name"
    done
}

