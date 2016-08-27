resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route" "internet_access" {
    route_table_id         = "${aws_vpc.default.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_subnet" "subnets" {
    vpc_id            = "${aws_vpc.default.id}"
    count             = "${length(split(",", lookup(var.aws_availability_zones, var.aws_region)))}"
    cidr_block        = "${cidrsubnet(var.vpc_cidr, 1, count.index)}"
    availability_zone = "${element(split(",", lookup(var.aws_availability_zones, var.aws_region)), count.index)}"
    map_public_ip_on_launch = true

    tags {
        "Name" = "subnet-${element(split(",", lookup(var.aws_availability_zones, var.aws_region)), count.index)}"
    }
}

# Our default security group to access the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "automate_terraform_default"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.16.2.0/23"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
