# Terraform
This method utilizes [Terraform](https://www.terraform.io/) to automate the provisioning of an AWS environment that hosts a simple HTML webpage hosted by two load-balanced EC2 instances running nginx.

## Pre-requisites

### On AWS

1. A valid user (IAM recommended) to obtain the access keys, with EC2 full access permission.

### On the SSH host

1. A working installation of [Terraform](https://www.terraform.io/downloads.html) for your favorite platform.
1. The AWS public key file located in the root directory of the project. It defaults to `automate.pub` but the filename can be changed in  [variables.tf](variables.tf).
1. Environment variables:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

## Usage Instructions

### Configuration

All configurations related to AWS such as the name of the key pair to use, instance type, AMI image, subnets, are contained in
[variables.tf](variables.tf).

Note that I am using the `ap-southeast-1` region as that is the closest to me. The file [variables.tf](variables.tf) contains some AMI id for not for all regions. They need to be added if not defined.

### Planning, Launching, and Destroying
- To examine what is going to be done, run `terraform plan`
- To launch the full infrastructure, run `terraform apply`.
- To destroy it, run `terraform destroy`.
