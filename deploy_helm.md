# Deploying helm charts in Azure

## Preparing the Docker Images
1. Starting from v4.5.0, each component has a separate Docker image (Control-plane, Gateway, Traffic-manager).
2. These Docker images do not contain any database connectors; therefore, we need to build custom Docker images based on each Docker image.
3. Sample Dockerfile
```Dockerfile
FROM wso2/wso2am-acp:4.5.0-rocky
ARG WSO2_SERVER_HOME=/home/wso2carbon/wso2am-acp-4.5.0
# copy MySQL connector to WSO2 server lib directory
COPY --chown=wso2carbon:wso2 component/mysql-connector.jar ${WSO2_SERVER_HOME}/repository/components/lib/
```

## Create a Database
1. Go to the Azure dashboard and navigate to `Azure Database for MySQL servers` to create a database.
2. Disable TLS:
    1. Go to the newly created database and navigate to Settings -> Server parameters.
    2. Find `require_secure_transport`, turn it OFF, and save the changes.
    3. Find `max_connections`, set it to 340
    4. Set `transaction_isolation` to `READ-COMMITTED`
3. Create required databases and users
```sql
CREATE DATABASE apim_db character set latin1;
CREATE DATABASE shared_db character set latin1;

CREATE USER 'apimadmin'@'%' IDENTIFIED BY 'apimadmin';
GRANT ALL ON apim_db.* TO 'apimadmin'@'%';

CREATE USER 'sharedadmin'@'%' IDENTIFIED BY 'sharedadmin';
GRANT ALL ON shared_db.* TO 'sharedadmin'@'%';

FLUSH PRIVILEGES;
```
4. Run DB scripts.
```bash
mysql -h apim-test.mysql.database.azure.com -P 3306 -u sharedadmin -p -Dshared_db < './dbscripts/mysql.sql';
mysql -h apim-test.mysql.database.azure.com -P 3306 -u apimadmin -p -Dapim_db < './dbscripts/apimgt/mysql.sql';
```

## Create AKS cluster
1. Create AKS cluster
2. Configure kubectl
```bash
az account set --subscription <subscription_id>
az aks get-credentials --resource-group <resource_group> --name <cluster_name> --overwrite-existing
```
3. Follow this guide to create an ingress controller - [Azure](https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/load-bal-ingress-c/create-unmanaged-ingress-controller?tabs=azure-cli)

## Create secret
1. Before deploying the Helm chart, we need to create a Kubernetes secret containing the keystores and truststore.
2. You can find the default keystore and truststore in the following location within any of the packs: `repository/resources/security/`
    > kubectl create secret generic jks-secret --from-file=wso2carbon.jks --from-file=client-truststore.jks

## Clone helm-apim
```bash
git clone https://github.com/wso2/helm-apim.git
```

## Deploy APIM-ACP
1. Update `values.yaml`
2. Deploy helm charts
```bash
helm install apim-acp ./control-plane
```

## Deploy APIM-KM (Optional)
1. The key-manager does not have a separate Docker image. You can run the key-manager using the APIM-ACP by setting `-Dprofile=key-manager`.
2. If you do not want to use a separate key-manager, you should point to the APIM-ACP service as the key-manager.
3. Update `values.yaml`.
4. Deploy helm charts
```bash
helm install apim-km ./key-manager
```

## Deploy APIM-TM
1. Update `values.yaml`
2. Deploy helm charts
```bash
helm install apim-tm ./traffic-manager
```

## Deploy APIM-GW
1. Update `values.yaml`
2. Deploy helm charts
```bash
helm install apim-gw ./gateway
```