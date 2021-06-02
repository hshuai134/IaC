// Create several ECS instances
provider "alicloud" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
}

resource "alicloud_vpc" "vpc" {
  name       = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/21"
  availability_zone = var.vswitch_availability_zone
}

resource "alicloud_security_group" "default" {
  name   = "default"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

module "ecs" {
 source                      = "./modules/ecs"
 region                      = var.region
 number_of_instances         = "3"
 vswitch_id                  = alicloud_vswitch.vsw.id
 group_ids                   = [alicloud_security_group.default.id]
 private_ips                 = ["172.16.0.10", "172.16.0.11", "172.16.0.12"]
 image_ids                   = ["ubuntu_18_04_64_20G_alibase_20190624.vhd"]
 instance_type               = "ecs.n2.small"
 internet_max_bandwidth_out  = 10
 associate_public_ip_address = false
 instance_name               = "my_module_instances_"
 host_name                   = "sample"
 internet_charge_type        = "PayByTraffic"
 password                    = "User@123"
 system_disk_category        = "cloud_ssd"
 data_disks = [
  {
    disk_category = "cloud_ssd"
    disk_name     = "my_module_disk"
    disk_size     = "50"
  }
 ]
}


module "eip" {
  source = "./modules/eip"
  region = var.region

  create               = true
  name                 = "ecs-eip"
  description          = "An EIP associated with ECS instance."
  bandwidth            = 1
  internet_charge_type = "PayByTraffic"
  instance_charge_type = "PostPaid"
  period               = 1
  resource_group_id    = ""
  tags = {
    Env      = "Private"
    Location = "foo"
  }

  # The number of instances created by other modules
  number_of_computed_instances = 3
  computed_instances = [
    {
      instance_ids  = module.ecs.this_instance_id
      instance_type = "EcsInstance"
      private_ips   = []
    }
  ]
}
