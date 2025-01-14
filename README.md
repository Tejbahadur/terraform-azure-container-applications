# terraform-azure-container-applications
> ACA => azure container applicatons is much like Amazon's ECS to provide fully managed container and management serivces.

Below are steps to build azure container applications infra with terraform.
<br/>
1) azure cli installation
2) Authenticate using azure cli and set environment variables
3) create azure container applications service
4) Teardown services created by terraform

## step-1 azure cli installation
Install azure cli using using this [link](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
## step-2 Authenticate using azure cli and set environment variables
execute below step to login 
```console
$ az login
```
a browser window will open for login. After login you will get subscription-id. save that subscription-id. It will be required in later steps.
```console
$ az account set --subscription "<SUBSCRIPTION ID>"
```
### create service principle
service principle is an application within Azure Active Directory with the authentication tokens Terraform needs to perform actions on your behalf.
```console
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION ID>"

Creating 'Contributor' role assignment under scope '/subscriptions/35akss-subscription-id'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}
```
### set your environment variables
It is recommended to save these values as an environment variables rather than saving them in terraform configuration
#### Windows configuration
In powershell terminal, set the following environment variables. Be sure to update the variable values with the values Azure returned in the previous command
```console
$Env:ARM_CLIENT_ID = "<APPID_VALUE>"
$Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
$Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
$Env:ARM_TENANT_ID = "<TENANT_VALUE>"
```
#### Linux/Mac configuration
In terminal, set the following environment variables. Be sure to update the variable values with the values Azure returned in the previous command
```console
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
```

## create azure container applications service
Run below script to create an azure container applications
```console
$ ./create-infra.sh
```

## Teardown services created by terraform
Run below script to delete all services created by terraform
```console
$ ./teardown.sh
```