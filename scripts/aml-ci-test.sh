#!/bin/bash

ver="0.03"
echo "test script version $ver"

# Get the version of azure-cli
az --version

# Log into the Azure CLI with the attached Managed Identity
echo "***logging into Azure...***"
az login --identity


# Config update for dynamic extension install 
# azure-cli ver. 2.
az config set extension.use_dynamic_install=yes_without_prompt


# Install Azure ML CLI
echo "***installing Azure ML CLI...***"
# az extension add -n azure-cli-ml
az extension add -s https://azurecliext.blob.core.windows.net/release/azure_cli_ml-1.22.0.1-py3-none-any.whl -y
echo "***Azure ML CLI installed successfully!***"



# # Get extension versions
# echo "***Get extension list with versions ***"
# az extension list


# #Set Azure subscription 
# az account show

exit 0
