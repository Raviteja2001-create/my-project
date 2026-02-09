
resource "aws_vpc" "myapp_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "my_app_subnet" {
source = "./Modules/Subnet"
subnet_cidr_block = var.subnet_cidr_block
avail_zone = var.avail_zone
env_prefix = var.env_prefix
vpc_id = aws_vpc.myapp_vpc.id
default_route_table_id = aws_vpc.myapp_vpc.default_route_table_id
}

module "my_instance" {
source = "./Modules/Webserver"
env_prefix = var.env_prefix
vpc_id = aws_vpc.myapp_vpc.id
 my_ip = var.my_ip
public_key_location = var.public_key_location
instance_type = var.instance_type
subnet_id = module.my_app_subnet.subnet_id
image_name = var.image_name


  
}

output "subnet_id" {
  value = module.my_app_subnet.subnet_id
}

