## az ml computetarget create computeinstance --help

This command is from the following extension: azure-cli-ml

Command
    az ml computetarget create computeinstance : Create an AzureML compute instance target.

Arguments
    --name -n        [Required] : Name of compute instance to create.
    --vm-size -s     [Required] : VM size to use for the compute target. More details can be found
                                  here: https://aka.ms/azureml-vm-details Default: Standard_NC6.
    --admin-user-ssh-public-key : SSH public key of the administrator user account.
    --description               : Description of the compute target.
    --no-wait                   : Flag to not wait for asynchronous calls.
    --path                      : Path to a project folder. Default: current directory.
    --resource-group -g         : Resource group corresponding to the provided workspace.
    --ssh-public-access         : State of the public SSH port. Possible values are: True or False.
    --subnet-name               : Name of the subnet inside the vnet.
    --subscription-id           : Specifies the subscription Id.
    --tag                       : Key/value tag to add (e.g. key=value ). Multiple tags can be
                                  specified with multiple --tag options.
    --user-object-id            : The AAD Object ID of the assigned user of this compute instance
                                  (preview).
    --user-tenant-id            : The AAD Tenant ID of the assigned user of this compute instance
                                  (preview).
    --vnet-name                 : Name of the virtual network.
    --vnet-resourcegroup-name   : Name of the resource group where the virtual network is located.
    --workspace-name -w         : Name of the workspace to create this compute target under.
    -v                          : Verbosity flag.

Global Arguments
    --debug                     : Increase logging verbosity to show all debug logs.
    --help -h                   : Show this help message and exit.
    --only-show-errors          : Only show errors, suppressing warnings.
    --output -o                 : Output format.  Allowed values: json, jsonc, none, table, tsv,
                                  yaml, yamlc.  Default: json.
    --query                     : JMESPath query string. See http://jmespath.org/ for more
                                  information and examples.
    --subscription              : Name or ID of subscription. You can configure the default
                                  subscription using `az account set -s NAME_OR_ID`.
    --verbose                   : Increase logging verbosity. Use --debug for full debug logs.

For more specific examples, use: az find "az ml computetarget create computeinstance"
