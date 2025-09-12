# Terraform: End-to-End Guide

Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define, provision, and manage infrastructure across multiple cloud providers (AWS, Azure, GCP) and on-prem systems using a simple declarative language (HCL).

By maintaining infrastructure in code, Terraform ensures **versioning, collaboration, repeatability, and scalability**.

---

## 1. Installation & Setup

1. Download Terraform from [terraform.io](https://www.terraform.io/downloads.html).
2. Install on your system (Windows, Linux, or Mac).
3. Verify installation:

```bash
terraform -v
```
<img width="1481" height="192" alt="image" src="https://github.com/user-attachments/assets/bd99ecd3-5dda-44ce-ace2-1480727cf9e9" />

4. (Optional) Install VS Code + Terraform extension.

---

## 2. Terraform Workflow

Terraform follows a simple 4-step process:

1. **Write** – Define infra in `.tf` files. The entire the infrastructure is defined like the resources used EC2,S3 Bucket,Subnet,RDS Etc.
2. **Plan** – Preview execution with `terraform plan`. In this step, terraform create a plan which includes what will be created,updated and destroy
3. **Apply** – Provision resources with `terraform apply`. The plan is executed 
4. **Destroy** – Remove infra with `terraform destroy`.
   
![terraform-architecture-components-workflow-2](https://github.com/user-attachments/assets/52b3c7fe-9ecb-4d10-8171-b55462ff5f5d)


---

## 3. Terraform Key Terms

* **Provider** – It is the Cloud platform or service (AWS, GCP, Azure, etc.).
* **Resource** – It is Infrastructure object (EC2, S3, VPC, etc.).
* **Variable** – Input values that we want to use in the Terraform code.
* **Output** – These are the Values exposed after execution.
* **State** – It is the current condition of infrastructure stored in `terraform.tfstate`.

---

## 4. Project Structure (Simple App Example)

```
simple-terraform-app/
│── main.tf
│── variables.tf
│── outputs.tf
│── provider.tf
│── backend.tf
│── modules/
│    |--EC2/
|        |-- main.tf
|        |-- variables.tf
|    |-- S3/..
|    |-- RDS/..
│── README.md
```
<img width="275" height="494" alt="image" src="https://github.com/user-attachments/assets/c7f7baf6-94b9-4aa7-860e-b05c105303ed" />

---

## 5. Terraform Commands

```bash
terraform init       # Initialize project, download providers
terraform plan       # Show execution plan
terraform apply      # Apply changes
terraform destroy    # Delete infrastructure
terraform validate   # Validate config
terraform workspace  # Manage environments
```

---

## 6. State Management
The `terraform.tfstate` stores the current state of the infrastructure,Tracks resources, metadata, and helps terraform compare the realworld infra to the one defined in the config file.
It also builds a dependency graph from the config file to determine the correct order of the operations.

* Terraform tracks infra in **state files** (`terraform.tfstate`).
* State maps resources in code to real cloud resources.
* Terraform remote backend : store states **remotely** using S3 + DynamoDB lock which prevents conflicts.

Example:
**backend.tf**

```hcl
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

```

---

## 7. Sample Code

**Main.tf** 

```hcl

resource "aws_instance" "simpleinstance" {
    ami = data.aws_ami.ubuntu.id

    instance_type = var.instance_type
      tags = {
         Name = "EC2 Instance"
       }
}

```

**Variables.tf**

```hcl
variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-22.04-amd64-server-*"]
  }
  owners = ["099720109477"]  
}

```

---

## 8. Modules
These are the Reusable packages, that covert the complex configurations of resources into reuseable blocks, to improve understandiblity and readablity 

* **Main module** – The directory where you run Terraform commands.
* **Child modules** – Reusable chunks of Terraform code.
**Main.tf**
<img width="307" height="234" alt="image" src="https://github.com/user-attachments/assets/605e38d8-d855-4663-98c1-e3acb305ca09" />

**Module structure**

<img width="261" height="115" alt="image" src="https://github.com/user-attachments/assets/a438b261-5594-4c2f-8e33-93e25b864e58" />

---

## 9. Workspaces (Multi-Environment)
These are the multiple instances of the same configuration, each of these instances contain it's own state files,
It is useful as it allows us to keep the dev,staging and prod all seprately. 


```bash
terraform workspace new dev
terraform workspace select dev
terraform workspace list
```

Use this to maintain `dev`, `staging`, and `prod` environments.

---
## 10. Different types of .tf files 
.tf files are plain text configuration files written in HCL (HashiCorp Configuration Language) or JSON. They all get loaded together in a directory (called a working directory or module), so the actual filename doesn’t matter to Terraform’s execution. 
However, for clarity and convention, teams often split configuration into different .tf files by purpose. 
- **main.tf** – The primary entry point of your configuration. Often contains resources, modules, and core infrastructure definitions.
- **variables.tf** – Defines all input variables used across your Terraform project (variable "name" { ... }).
- **outputs.tf** – Declares the outputs you want to expose after terraform apply (useful when other modules or people need those values).
- **provider.tf** – Specifies providers (e.g., AWS, Azure, GCP, Kubernetes) and their configurations.
- **backend.tf** – Defines the backend for state storage (e.g., S3, GCS, Terraform Cloud).
---
## 11. Infrastructure Drift

* This Drift occurs when  changes outside Terraform (e.g., manual console edits).
* `terraform plan` is used to detect the Infrastructure Drift.
* Best practice: **never manually edit infra** outside Terraform. and regularly perform the `terraform plan` 

---

## 12. Real-World Best Practices

* Store state in remote backend.
* Use separate workspaces for environments.
* Always run `terraform plan` before `apply`.
* Use version control (GitHub).
* Integrate with CI/CD (e.g., GitHub Actions).

---

## 13. Further Learning

* [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
* [Terraform Registry](https://registry.terraform.io/)
* [HashiCorp Learn](https://learn.hashicorp.com/terraform)

---
