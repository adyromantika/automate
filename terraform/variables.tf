variable "key_name" {
    description = "Name of the SSH keypair to use for AWS"
    default = "automate_terraform"
}

variable "public_key_path" {
    default = "../automate.pub"
}

variable "aws_region" {
    description = "AWS region to launch the infrastructure"
    default = "ap-southeast-1"
}

variable "aws_availability_zones" {
    default = {
        "ap-southeast-1" = "ap-southeast-1a,ap-southeast-1b"  # Asia Pacific (Singapore)
        "ap-southeast-2" = "ap-southeast-2a,ap-southeast-2b"  # Asia Pacific (Sydney)
        "ap-northeast-1" = "ap-northeast-1a,ap-northeast-1c"  # Asia Pacific (Tokyo)
        "ap-northeast-2" = "ap-northeast-2a,ap-northeast-2c"  # Asia Pacific (Seoul)
        "ap-south-1"     = "ap-south-1a,ap-south-1b"          # Asia Pacific (Mumbai)
        "eu-west-1"      = "eu-west-1a,eu-west-1b,eu-west-1c" # EU (Ireland)
        "eu-central-1"   = "eu-central-1a,eu-central-1b"      # EU (Frankfurt)
        "us-west-1"      = "us-west-1b,us-west-1c"            # US West (N. California)
        "us-west-2"      = "us-west-2a,us-west-2b,us-west-2c" # US West (Oregon)
        "us-east-1"      = "us-east-1c,us-west-1d,us-west-1e" # US East (N. Virginia)
        "sa-east-1"      = "sa-east-1a,sa-east-1c"            # South America (São Paulo)
    }
}

variable "aws_instance_type" {
    default = "t2.micro"
}

# ubuntu-trusty-14.04 (x64)
variable "aws_amis" {
    description = "Every region has different AMI IDs"
    default = {
        "ap-southeast-1" = "ami-21d30f42"
        "ap-northeast-1" = "ami-a21529cc"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "172.16.4.0/22"
}

variable "subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = {
        "ap-southeast-1a" = "172.16.4.0/24"
        "ap-southeast-1b" = "172.16.5.0/24"
    }
}

