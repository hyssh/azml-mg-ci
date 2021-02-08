#!/bin/bash

ver="0.02"
echo "aml-ci-shutdown script version $ver"

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

echo "Azure subscription: $azsub"
echo "Resource Group: $resource_group_name"
echo "Workspace Name: $aml_workspace_name"


if [[ -z "${CI_EXCEPTION}" ]];
then
    echo "No exceptions were found, proceeding with shutdown..."

    #Instantiate full list array
    declare -a cifinallist

    #Populate full list array
    for row in $(az ml computetarget list -w $aml_workspace_name -g $resource_group_name --query '[].name' | jq -r '.[]')
    do 
        cifinallist+=(${row})
    done

    #Display full list array
    echo "List of Compute Instances to be shutdown:"
    echo ${cifinallist[@]}

    #Perform compute instance shutdown
    for i in "${cifinallist[@]}"
    do
        az ml computetarget computeinstance stop -n $i -w $aml_workspace_name -g $resource_group_name
    done
 
    echo "Compute Instance shutdown process complete"

    exit 0
else
    # Instantiate exception array
    declare -a ciex

    # Capture JSON object from ENV and store in array
    for row in $(echo $CI_EXCEPTION | jq -r '.vmname[]')
    do
        ciex+=(${row})
    done

    #Display VM Exception list
    echo "VM Exception list is as follows:"
    echo ${ciex[@]}

    #Instantiate full list array
    declare -a cifulllist

    #Populate full list array
    for row in $(az ml computetarget list -w $aml_workspace_name -g $resource_group_name --query '[].name' | jq -r '.[]')
    do 
        cifulllist+=(${row})
    done

    #Display full list array
    echo "Full list of compute instances:"
    echo ${cifulllist[@]}

    #Instantiate final list array
    declare -a cifinallist

    #Populate final list array
    for i in "${cifulllist[@]}"; do
        skip=
        for j in "${ciex[@]}"; do
            [[ $i == $j ]] && { skip=1; break; }
        done
        [[ -n $skip ]] || cifinallist+=("$i")
    done

    #Display final list array
    echo "List of Compute Instances to be shutdown:"
    echo ${cifinallist[@]}

    #Perform compute instance shutdown
    for i in "${cifinallist[@]}"
    do
        az ml computetarget computeinstance stop -n $i -w $aml_workspace_name -g $resource_group_name
    done
    
    echo "Compute Instance shutdown process complete"

    exit 0
fi
