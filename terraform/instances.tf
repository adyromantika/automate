resource "aws_instance" "webservers" {
    ami                    = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type          = "${var.aws_instance_type}"
    count                  = 2
    subnet_id              = "${element(aws_subnet.subnets.*.id, count.index%2)}"
    vpc_security_group_ids = ["${aws_security_group.webservers.id}"]
    key_name               = "${aws_key_pair.auth.id}"

    connection {
        user = "ubuntu"
        agent = true
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update",
            "sudo apt-get -y install nginx",
            "sudo service nginx start"
        ]
    }
}


# Our default security group to access the instances over SSH and HTTP
resource "aws_security_group" "webservers" {
  name        = "webservers"
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
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
