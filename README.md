# Examples how to use Terraform

This is a demo which configures Docker containers using Terraform. All the resources are set up only on your local computer.

## Usage:

1. Install [Docker](https://docs.docker.com/engine/install/) engine
2. Run the commands down below

### Creating Terraform workspaces

```
terraform workspace new dev
terraform workspace new prod
```

#### Working on Terraform Dev workspace

```
terraform workspace select dev
terraform init
terraform apply
```

```
terraform output
docker ps -f name=dev
```

```
terraform destroy
```

#### Working on Terraform Prod workspace

```
terraform workspace select prod
terraform init
terraform apply
```

```
terraform output
docker ps -f name=prod
```

```
terraform destroy
```

## Based on:

* https://www.udemy.com/course/terraform-certified/
* https://github.com/morethancertified/mtc-terraform
