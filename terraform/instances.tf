resource "aws_instance" "webservers" {
    ami                    = "${lookup(var.aws_amis, var.aws_region)}"
    instance_type          = "${var.aws_instance_type}"
    count                  = 2
    subnet_id              = "${element(aws_subnet.subnets.*.id, count.index%2)}"
    vpc_security_group_ids = ["${aws_security_group.default.id}"]
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

