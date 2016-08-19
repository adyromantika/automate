# AWS Automation [![Build Status](https://travis-ci.org/adyromantika/automate.svg?branch=master)](https://travis-ci.org/adyromantika/automate)

This project utilizes [ansible](https://github.com/ansible/ansible) to automate the provisioning of an AWS environment that hosts a simple load-balanced HTML webpage hosted by two load-balanced EC2 instances running nginx.

## Pre-requisites

### On AWS

1. A configured a key pair to be used to access the EC2 instances.
1. A valid user (IAM recommended) to obtain the access keys, with EC2 full access permission.

### On the SSH host

1. A working installation of ansible and the boto Python module.
1. The AWS key file located in the root directory of the project. It defaults to `automate.pem` but the filename can be changed in  [scripts/provision.sh](scripts/provision.sh). Please ignore `automate.pem.enc` file as that is provided for Travis builds.
1. I decided to use environment variables to make it easy to change in Travis:
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY

## Usage Instructions

### Configuration

All configurations related to AWS such as the name of the key pair to use, instance type, AMI image, subnets, are contained in
[ansible/host_vars/localhost](ansible/host_vars/localhost)

Note that I am using the `ap-southeast-1` region as that is the closest to me. If you change this, make sure to change the AMI image to the one corresponding to your region.

### Launching
To launch the full environment, one needs to run `scripts/provision.sh`.

## Caveat

On some Python virtual environments, you may receive:

`fatal: [localhost]: FAILED! => {"changed": false, "failed": true, "msg": "boto required for this module"}`

The workaround:

`export PYTHONPATH=<PATH_TO_VIRTUALENV>/lib/python2.x/site-packages`

Remember to replace `<PATH_TO_VIRTUALENV>` and `x` with your version of Python.

---

# Why it is built this way

I used to have this in bare Python scripts. Also utilizing boto, scripts are fun to write but they can not be easily reused. Using configuration management such as ansible, puppet, chef, or salt (to name a few), code can be easily reused and adapted as needed.

Reasons I am embracing *Infrastructure as Code*:

1. It is easier to understand by others (reduction of cost of time by providing reusability and better readability)
1. It is fast (greater speed both in execution and in writing code)
1. It provides a framework / structure (reduce risk of errors and bugs compared to bare scripts)

This project has a simple flow of:

1. Launch a VPC if not already there with two subnets, one in each availability zone
1. Launch exactly one EC2 instance in each of the subnets in the VPC
1. Create a load balancer that is attached to the subnets
1. Setup nginx and copy file to serve onto the EC2 instances
1. Add the EC2 instances into the load balancer
1. Check for the webpage via the load balancer
1. Check that SSH is listening on the instances

---

# Postmortem

## Did it go smoothly?

It went smoothly. Ansible is a good tool to provision instances from scratch, and being idempotent it is also a testing tool to make sure everything is configured exactly as we intend it to be.

## Surprises or lessons learned

- The security group of the load balancer needs to be explicitly added to the security group of the instances, otherwise the load balancer will not be able to connect (or perform health check), causing the load balancer to ignore the instances.
- Learned how to use Travis for public projects, and that it can encrypt files to hide sensitive but required information in GitHub.
- The same OS image (e.g. Ubuntu 14.04) has different AMI IDs in different regions.

## Production ready?

Out of the box, no. With further refinements, sure.

### Security

- Preferably, port 22 should be open only within the VPC, or to specific IP address. It is open in this project since the ansible host doesn't have a static IP. An excellent way is to have a management / jumper machine acting as ansible host in the VPC, that can be accessed from outside.

### Complexity

- This project is very simple as it deploys a single HTML file. In the real production environment there would be more requirements that we need to observe, for example load balancer stickiness (that does not matter for static files in this project), or sessions handling.

### Scaling

- Ansible (without the Tower) is a push tool, making it an unsuitable tool for autoscaling on demand plain instances. It can, however be used for configuring autoscaling provided that we have AMI images and immutable servers.

