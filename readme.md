# 🚀 Azure Static Website Deployment with Terraform

This repository contains a Terraform configuration to provision an **Azure Storage Account** and configure it for **Static Website Hosting**. It also deploys sample `index.html` and `error.html` files to the `$web` container.

---

## 💻 Prerequisites

Before running this configuration, you must have the following installed and set up:

-   **[Terraform](https://www.terraform.io/downloads.html):** Used to provision the infrastructure.
-   **[Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) or Service Principal:** For authenticating with Azure.
-   **A folder structure** that includes the HTML files as expected by the script:

    ```
    .
    ├── resources.tf
    ├── outputs.tf
    ├── providers.tf
    ├── variables.tf
    └── static/
        ├── index.html
        └── error.html
    ```

    > **Note:** The `resources.tf` file is assumed to contain the provided Terraform code.

---

## ✨ Resources Created

The script defines the following Azure resources:

| Resource Type                            | Resource Name                                 | Description                                                                                                                            |
| :--------------------------------------- | :-------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------- |
| `azurerm_resource_group`                 | `resourceGroup`                               | Creates an Azure Resource Group named **`test-rg1`** in **`South Central US`**.                                                        |
| `azurerm_storage_account`                | `storageAccount`                              | Creates a Standard, LRS Storage Account named **`storageacntswadeploy`** within the resource group.                                    |
| `azurerm_storage_account_static_website` | `storageAccountStaticWebsite`                 | Enables the Static Website feature on the Storage Account, setting `index.html` as the index document and `error.html` for 404 errors. |
| `azurerm_storage_blob`                   | `storageAccountBlob1` & `storageAccountBlob2` | Uploads the `index.html` and `error.html` files from the local `./static` directory into the special **`$web`** container.             |

---

## 🛠️ Usage

### 1. **Authentication**

Ensure you are logged in to the correct Azure subscription:

```bash
az login

```

### 2. **Initialize Terraform**

Initialize the directory to download the necessary Azure provider:

```bash
terraform init
```

### 3. **Review and Plan**

Generate an execution plan and review the infrastructure changes before applying:

```bash
terraform plan
```

### 4. **Apply Configuration**

Apply the changes to create the resources in Azure. You will be prompted to confirm:

```bash
terraform apply
```

### 5. **Destroy Resources (Cleanup)**

To remove all provisioned resources and clean up your Azure environment:

```bash
terraform destroy
```

## 🔗 Getting the Website URL

A standard website endpoint format is:

-   https://[STORAGE_ACCOUNT_NAME].[REGION].web.core.windows.net
