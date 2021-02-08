#!/bin/bash

ver="0.02"
echo "aml-ci-create version $ver"

# Config update for dynamic extension install 
az config set extension.use_dynamic_install=yes_without_prompt


# Install Azure ML CLI
echo "***installing Azure ML CLI...***"
az extension add -n azure-cli-ml
echo "***Azure ML CLI installed successfully!***"


# Get extension versions
echo "***Get extension list with versions ***"
az extension list --output tsv
echo "***Get extension list with versions successfully***"


# Log into the Azure CLI with the attached Managed Identity
echo "***logging into Azure...***"
az login --identity --output tsv
echo "***logged into Azure successfully!***"


#Set Azure subscription 
az account show --query '[name, id]'


# Input CI_INPUTDATA samples to create Compute Instance
# CI_INPUTDATA='[
#         {
#             "Name":"azmlci00",
#             "Vm-size":"STANDARD_DS3_V2",
#             "Resource-group":"mtcs-dev-aml-rg",
#             "Workspace-name":"mtcs-dev-aml",
#             "TenantID":"########-b5f3-426e-b933-b1fe7cddcd63",
#             "UserID":"########-86c4-4504-a9df-6dad6a918702"
#         },
#         {
#             "Name":"azmlci01",
#             "Vm-size":"STANDARD_DS3_V2",
#             "Resource-group":"mtcs-dev-aml-rg",
#             "Workspace-name":"mtcs-dev-aml",
#             "TenantID":"########-b5f3-426e-b933-b1fe7cddcd63",
#             "UserID":"########-86c4-4504-a9df-6dad6a918702"
#         }
#     ]'


echo "________________________________________"
echo "New CI list as follows:"
echo $CI_INPUTDATA | jq -r '.[]'
echo "________________________________________"


if [[ ! -z "${CI_INPUTDATA}" ]];
then
    for item in $(echo "${CI_INPUTDATA}" | jq -c '.[]')
    do
        declare name
        declare vmsize
        declare resourcegroupname
        declare workspacename
        declare tenantid
        declare userid

        name=$(echo "${item}" | jq -r '.Name')
        vmsize=$(echo "${item}" | jq -r '."Vm-size"')
        resourcegroupname=$(echo "${item}" | jq -r '."Resource-group"')
        workspacename=$(echo "${item}" | jq -r '."Workspace-name"')
        tenantid=$(echo "${item}" | jq -r '.TenantID')
        userid=$(echo "${item}" | jq -r '.UserID')

        # If specified name of VM is already in use  following command won't work
        az ml computetarget create computeinstance -n $name --vm-size $vmsize -w $workspacename -g $resourcegroupname --user-tenant-id "'$tenantid'" --user-object-id "'$userid'" --no-wait --verbose
    done

    echo "Compute Instance creation process completed"

    exit 0
else
    echo "There is no new request to create Compute Instance"

    exit 0
fi
