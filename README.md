# Azure Resource Managed by Terraform

## Usage Context

Given that you are in a team in your organazation, and **you're an owner of an Azure subscription**. you want to

- **Share Azure with your team**, and everyone can use Azure resources with your subscription.
- Azure resources can be isolated by user.
- A private resource group can only manage by its owner.
- A Public resource group can ben shared with all team members.
- When someone left the team, his resources can be destroyed easily.

## Set up
if you are an newbie to Azure and Terraform, please read official document first to prepare some basic environment: https://www.terraform.io/docs/providers/azurerm/index.html

```shell
terraform init
cp env.tfvars.sample env.tfvars
##Modify the env.tfvars according to your case
terraform apply -var-file="env.tfvars"

```

## Input varibles

- team_name : Team's name, and will be used for user group name
- user_emails: Users' Emails in your team, example:
   ```terraform
   ```
- resource_location：Default location of resource groups

sample:
```tf
team_name = "tfboys"
resource_location = "Central US"
user_emails = [
  "xxx1@wangbaiyuan.cn",
  "xxx2@wangbaiyuan.cn",
  "xxx3@wangbaiyuan.cn",
]
```

## What will be created?

- an Azure AD group contains your team members
- each members has his/her private resource group, and he/she is its owner.
- a public resource group sharing for whole team, and every members are its contributer.
