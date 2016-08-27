# AWS Automation [![Build Status](https://travis-ci.org/adyromantika/automate.svg?branch=master)](https://travis-ci.org/adyromantika/automate)

This project's purpose is to automate the provisioning of an AWS environment that hosts a simple load-balanced HTML webpage hosted by two load-balanced EC2 instances running nginx.

There are currently two methods, and their respective READMEs are in their own folders:

1. Ansible - [Ansible](ansible/)
1. Terraform - [Terraform](terraform/)

**Please note that if you execute any of these, you will be billed on your AWS account.**

Travis builds will not run for pull requests as there is risk of AWS resources getting launched without me realizing it.

## Common Pre-requisites

### On AWS

1. A valid user (IAM recommended) to obtain the access keys, with EC2 full access permission.

### On The Host Where This is Run

1. There are various methods to set the keys but in this project environment variables are used to make it easy to change in Travis:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

## Todo

1. Ansible: cleanup infrastructure after Travis run
1. Terraform: send the file to be hosted to the instances
1. Add Terraform support for the Vagrant machine
1. Add Terraform execution to Travis
1. Add infrastructure tests using something like [KitchenCI](http://kitchen.ci/)

