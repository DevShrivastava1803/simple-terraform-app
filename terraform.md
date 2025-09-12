# Terraform Concepts

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp that allows you to define, provision, and manage cloud infrastructure using a simple declarative configuration language. It works across multiple cloud providers (like AWS, Azure, GCP) and on-premises systems, enabling consistent and automated infrastructure deployment. By maintaining infrastructure in code, Terraform makes it easier to version, collaborate, and ensure repeatability, reducing manual errors and improving scalability.


## 1. Core Workflow Architecture

Terraform follows a simple workflow:

1. **Write** – Define infrastructure as code in `.tf` files.

2. **Plan** – Preview the execution plan with `terraform plan`.

3. **Apply** – Provision infrastructure with `terraform apply`.

4 .  **Destroy** – Tear down infrastructure with `terraform destroy`.



This cycle ensures predictable and repeatable infrastructure management.



---



 ## 2. State Files

 - Terraform stores the current state of infrastructure in a  **state file** (`terraform.tfstate`).

 - It maps real-world resources to your configuration.

 - Important for  **tracking changes**,  **collaboration**, and  **dependency resolution**.

 - Should be stored securely (e.g., S3 backend with encryption).



---



 ## 3. How Terraform Works

 - Terraform reads the  **HCL configuration** files.

 - It compares the desired state (code) with the current state (from state file).

 - It calculates a  **plan** and executes API calls to cloud providers to reconcile differences.



---



 ## 4. Modules

 - A  **module** is a reusable container of Terraform code.

 - Helps structure infrastructure into logical components.

 - Can be:

&nbsp; -  **Root module** – main directory where Terraform is executed.

&nbsp; -  **Child modules** – reusable modules imported with `module` blocks.

 - Promotes  **reusability** and  **consistency**.



---



 ## 5. Data Sources

 -  **Data sources** fetch  **read-only information** from providers.

 - Example: fetching the latest AWS AMI ID for Ubuntu.

 - Useful for referencing existing resources instead of creating new ones.



---



 ## 6. Infrastructure Drift

 -  **Drift** happens when the real infrastructure changes outside Terraform (e.g., manual edits in AWS Console).

 - Terraform detects drift during `terraform plan` by comparing state with reality.

 - Best practice: avoid manual changes outside Terraform.



---



 ## 7. Workspaces

 - Workspaces allow  **multiple state files** within the same configuration.

 - Example: `dev`, `staging`, `prod` environments.

 - Commands:

&nbsp; - `terraform workspace new dev`

&nbsp; - `terraform workspace select dev`

 - Helps separate environments without duplicating code.



---



 ## 8. Terraform Commands

 - `terraform init` – Initialize working directory and download providers.

 - `terraform plan` – Preview changes before applying.

 - `terraform apply` – Apply infrastructure changes.

 - `terraform destroy` – Destroy managed infrastructure.

 - `terraform fmt` – Format Terraform code.

 - `terraform validate` – Validate configuration files.



---



 ## 9. Methods to Provision Infrastructure

1 .  **Declarative (Terraform)** – Define desired state in code and use IAAC platforms.

2 .  **Imperative (CLI/APIs)** – Execute step-by-step instructions manually or via scripts.

3 .  **GUI** – Use the cloud gui to create the resources.

---
## 10. Different types of .tf files

 .tf files are plain text configuration files written in HCL (HashiCorp Configuration Language) or JSON. They all get loaded together in a   directory (called a working directory or module), so the actual filename doesn’t matter to Terraform’s execution. However, for clarity and  convention, teams often split configuration into different .tf files by purpose.

 - **main.tf** – The primary entry point of your configuration. Often contains resources, modules, and core infrastructure definitions.

 - **variables.tf** – Defines all input variables used across your Terraform project (variable "name" { ... }).

 - **outputs.tf** – Declares the outputs you want to expose after terraform apply (useful when other modules or people need those values).

 - **provider.tf** – Specifies providers (e.g., AWS, Azure, GCP, Kubernetes) and their configurations.

 - **backend.tf** – Defines the backend for state storage (e.g., S3, GCS, Terraform Cloud).

---



 ## 10. AWS Remote Backend

 - Stores Terraform state remotely for  **team collaboration**

 - Common remote backend:  **S3 with DynamoDB locking**

 - Example:



```hcl

terraform {

 backend "s3" {

   bucket         = "my-terraform-state"

   key            = "env/dev/terraform.tfstate"

   region         = "us-east-1"

   dynamodb _table = "terraform-locks"

   encrypt        = true

 }

}



