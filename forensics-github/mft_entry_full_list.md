┌──(kali㉿kali)-[~/Desktop/Forensics/Assignment/ntfs]
└─$ analyze_all_mft_entries                   
Processing: mft-entry-0.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000198 (408 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 04
File name hex: 24004d0046005400
File Name: $MFT
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 72 Bytes
Logical Size: 70656 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 19 clusters
Cluster Offset: 4 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x148
Attribute Size in Bytes: 72 Bytes
Logical Size: 16 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 1 clusters
Cluster Offset: 2 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0xb0000000 ($Index_Bitmap)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x190
End of attributes reached.


Processing: mft-entry-1.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000158 (344 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 08
File name hex: 24004d00460054004d00690072007200
File Name: $MFTMirr
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x108
Attribute Size in Bytes: 72 Bytes
Logical Size: 4096 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 1 clusters
Cluster Offset: 3071 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x150
End of attributes reached.


Processing: mft-entry-2.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000158 (344 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 08
File name hex: 24004c006f006700460069006c006500
File Name: $LogFile
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x108
Attribute Size in Bytes: 72 Bytes
Logical Size: 2097152 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 512 clusters
Cluster Offset: 3072 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x150
End of attributes reached.


Processing: mft-entry-3.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001c8 (456 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 07
File name hex: 240056006f006c0075006d006500
File Name: $Volume
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0xE8
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x168
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x60000000 ($Volume_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x180
Attribute Size in Bytes: 40 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x70000000 ($Volume_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x1A8
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x1C0
End of attributes reached.


Processing: mft-entry-4.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001c0 (448 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 08
File name hex: 24004100740074007200440065006600
File Name: $AttrDef
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0xF0
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x170
Attribute Size in Bytes: 72 Bytes
Logical Size: 2560 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 1 clusters
Cluster Offset: 774 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1B8
End of attributes reached.


Processing: mft-entry-5.dd
Allocation Status: 0x0003 (Unknown)
Logical File Size: 0x00000200 (512 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 01
File name hex: 2e00
File Name: .
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0xE0
Attribute Size in Bytes: 72 Bytes
Logical Size: 4140 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 2 clusters
Cluster Offset: 771 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x128
Attribute Size in Bytes: 88 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x180
Attribute Size in Bytes: 80 Bytes
Logical Size: 4096 Bytes
Offset to Run List: 0x0048

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 1 clusters
Cluster Offset: 773 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0xa0000000 ($Index_Allocation)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1D0
Attribute Size in Bytes: 40 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0xb0000000 ($Index_Bitmap)
Resident Status: Resident
-----------------------------
Current Offset: 0x1F8
End of attributes reached.


Processing: mft-entry-6.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000150 (336 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 07
File name hex: 24004200690074006d0061007000
File Name: $Bitmap
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 72 Bytes
Logical Size: 768 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 1 clusters
Cluster Offset: 775 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x148
End of attributes reached.


Processing: mft-entry-7.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001b8 (440 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 05
File name hex: 240042006f006f007400
File Name: $Boot
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0xE8
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x168
Attribute Size in Bytes: 72 Bytes
Logical Size: 8192 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 2 clusters
Cluster Offset: 0 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1B0
End of attributes reached.


Processing: mft-entry-8.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000178 (376 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 08
File name hex: 240042006100640043006c0075007300
File Name: $BadClus
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x108
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x120
Attribute Size in Bytes: 80 Bytes
Logical Size: 25161728 Bytes
Offset to Run List: 0x0048

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
extract_run_list:47: bad math expression: operator expected at `Usage: let...'
Run Length: 6143 clusters
Cluster Offset: 0 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x170
End of attributes reached.


Processing: mft-entry-9.dd
Allocation Status: 0x0009 (Unknown)
Logical File Size: 0x000002a8 (680 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 07
File name hex: 2400530065006300750072006500
File Name: $Secure
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 80 Bytes
Logical Size: 262396 Bytes
Offset to Run List: 0x0048

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 65 clusters
Cluster Offset: 776 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x150
Attribute Size in Bytes: 176 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x200
Attribute Size in Bytes: 160 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x2A0
End of attributes reached.


Processing: mft-entry-10.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000198 (408 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 07
File name hex: 2400550070004300610073006500
File Name: $UpCase
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 72 Bytes
Logical Size: 131072 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 32 clusters
Cluster Offset: 841 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x148
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0028
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x190
End of attributes reached.


Processing: mft-entry-11.dd
Allocation Status: 0x0003 (Unknown)
Logical File Size: 0x00000280 (640 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 07
File name hex: 240045007800740065006e006400
File Name: $Extend
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 376 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x278
End of attributes reached.


Processing: mft-entry-12.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000120 (288 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x118
End of attributes reached.


Processing: mft-entry-13.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000120 (288 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x118
End of attributes reached.


Processing: mft-entry-14.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000120 (288 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x118
End of attributes reached.


Processing: mft-entry-15.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x00000120 (288 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 24 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x80000000 ($Data)
Resident Status: Resident
-----------------------------
Current Offset: 0x118
End of attributes reached.


Processing: mft-entry-16.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-17.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-18.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-19.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-20.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-21.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-22.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-23.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000088 (136 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
End of attributes reached.


Processing: mft-entry-24.dd
Allocation Status: 0x000d (Unknown)
Logical File Size: 0x00000270 (624 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 11
File Name Character Count: 06
File name hex: 2400510075006f0074006100
File Name: $Quota
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 120 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x178
Attribute Size in Bytes: 240 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x268
End of attributes reached.


Processing: mft-entry-25.dd
Allocation Status: 0x000d (Unknown)
Logical File Size: 0x00000158 (344 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 11
File Name Character Count: 06
File name hex: 24004f0062006a0049006400
File Name: $ObjId
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 80 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x150
End of attributes reached.


Processing: mft-entry-26.dd
Allocation Status: 0x000d (Unknown)
Logical File Size: 0x00000160 (352 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 96 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x98
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 11
File Name Character Count: 08
File name hex: 24005200650070006100720073006500
File Name: $Reparse
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x108
Attribute Size in Bytes: 80 Bytes
Offset to Attribute Stream: 0x0020
Attribute Type: 0x90000000 ($Index_Root)
Resident Status: Resident
-----------------------------
Current Offset: 0x158
End of attributes reached.


Processing: mft-entry-27.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-28.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-29.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-30.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-31.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-32.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-33.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-34.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-35.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-36.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-37.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-38.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-39.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-40.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-41.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-42.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-43.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-44.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-45.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-46.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-47.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-48.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-49.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-50.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-51.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-52.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-53.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-54.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-55.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-56.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-57.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-58.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-59.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-60.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-61.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-62.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-63.dd
Allocation Status: 0x0000 (File, Deleted)
Logical File Size: 0x00000040 (64 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
End of attributes reached.


Processing: mft-entry-64.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001c0 (448 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 136 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 17
File name hex: 41006c006900630065002d0069006e002d0057006f006e006400650072006c0061006e0064002e00740078007400
File Name: Alice-in-Wonderland.txt
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x108
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x170
Attribute Size in Bytes: 72 Bytes
Logical Size: 173595 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 43 clusters
Cluster Offset: 3584 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1B8
End of attributes reached.


Processing: mft-entry-65.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001a8 (424 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 0b
File name hex: 440072006100630075006c0061002e00740078007400
File Name: Dracula.txt
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0xF0
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x158
Attribute Size in Bytes: 72 Bytes
Logical Size: 883160 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 216 clusters
Cluster Offset: 3627 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1A0
End of attributes reached.


Processing: mft-entry-66.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001a8 (424 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 112 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 09
File name hex: 700068006f0074006f002e006a0070006700
File Name: photo.jpg
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0xF0
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x158
Attribute Size in Bytes: 72 Bytes
Logical Size: 3816113 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 932 clusters
Cluster Offset: 3843 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1A0
End of attributes reached.


Processing: mft-entry-67.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001c0 (448 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 136 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 17
File name hex: 500072006900640065002d0061006e0064002d005000720065006a00750064006900630065002e00740078007400
File Name: Pride-and-Prejudice.txt
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x108
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x170
Attribute Size in Bytes: 72 Bytes
Logical Size: 799738 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 196 clusters
Cluster Offset: 873 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1B8
End of attributes reached.


Processing: mft-entry-68.dd
Allocation Status: 0x0001 (File, Allocated)
Logical File Size: 0x000001b8 (440 bytes)
Offset to First Attribute: 0x0038 (56 bytes)


Analyzing MFT attributes:
Attribute Size in Bytes: 72 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x10000000 ($Standard_Information)
Resident Status: Resident
-----------------------------
Current Offset: 0x80
Attribute Size in Bytes: 128 Bytes
Offset to Attribute Stream: 0x0018
Parent MFT Entry: 5
File Name Character Count: 13
File name hex: 53006800650072006c006f0063006b002d0048006f006c006d00650073002e00740078007400
File Name: Sherlock-Holmes.txt
Attribute Type: 0x30000000 ($File_Name)
Resident Status: Resident
-----------------------------
Current Offset: 0x100
Attribute Size in Bytes: 104 Bytes
Offset to Attribute Stream: 0x0018
Attribute Type: 0x50000000 ($Security_Descriptor)
Resident Status: Resident
-----------------------------
Current Offset: 0x168
Attribute Size in Bytes: 72 Bytes
Logical Size: 607788 Bytes
Offset to Run List: 0x0040

>>>>>>>>>>>>>>>>>>>>
Extracting Run List:
Run Length: 149 clusters
Cluster Offset: 4968 clusters
End of Run List reached.
<<<<<<<<<<<<<<<<<<<<<<<

Attribute Type: 0x80000000 ($Data)
Resident Status: Non-Resident
-----------------------------
Current Offset: 0x1B0
End of attributes reached.
