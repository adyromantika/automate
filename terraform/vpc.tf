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
    cidr_block        = "${cidrsubnet(var.vpc_cidr, 2, count.index)}"
    availability_zone = "${element(split(",", lookup(var.aws_availability_zones, var.aws_region)), count.index)}"
    map_public_ip_on_launch = true

    tags {
        "Name" = "subnet-${element(split(",", lookup(var.aws_availability_zones, var.aws_region)), count.index)}"
    }
}

