#!/bin/bash

ver="0.01"
echo "test script version $ver"

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

exit 0
