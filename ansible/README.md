# Ansible
This method utilizes [ansible](https://github.com/ansible/ansible) to automate the provisioning of an AWS environment that hosts a simple HTML webpage hosted by two load-balanced EC2 instances running nginx.

## Pre-requisites

### On AWS

1. A configured a key pair to be used to access the EC2 instances.
1. A valid user (IAM recommended) to obtain the access keys, with EC2 full access permission.

### On the SSH host

1. A working installation of ansible and the boto Python module.
1. The AWS key file located in the root directory of the project. It defaults to `automate.pem` but the filename can be changed in  [scripts/prepare-env.sh](../scripts/prepare-env.sh). Please ignore `automate.pem.enc` file as that is provided for Travis builds.
1. Environment variables:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

## Usage Instructions

### Configuration

All configurations related to AWS such as the name of the key pair to use, instance type, AMI image, subnets, are contained in
[host_vars/localhost](host_vars/localhost)

Note that I am using the `ap-southeast-1` region as that is the closest to me. If you change this, make sure to change the AMI image to the one corresponding to your region.

### Launching
To launch the full environment, one needs to run `scripts/ansible-launch.sh`.

## Caveat

On some Python virtual environments, you may receive:

`fatal: [localhost]: FAILED! => {"changed": false, "failed": true, "msg": "boto required for this module"}`

The workaround:

`export PYTHONPATH=<PATH_TO_VIRTUALENV>/lib/python2.x/site-packages`

Remember to replace `<PATH_TO_VIRTUALENV>` and `x` with your version of Python.

## Quick Start with Vagrant

1. Clone this repository
1. Create an AWS key pair with the name `automate`, save it as `automate.pem` in the root directory of the repository
1. Execute `vagrant up`
1. Enter the vm with `vagrant ssh`
1. Export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY into the environment
1. Execute `~/automate/scripts/provision.sh`

Warning: Make sure to check and change the parameters in `ansible/host_vars/localhost` if you have an existing infrastructure, to avoid any issues.
