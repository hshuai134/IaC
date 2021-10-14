variable "vswitch_availability_zone" {
   description = "交换机可用区域地址"
   default = "cn-hangzhou-b"
}

variable "region" {
   description = "区域"
   default = "cn-hangzhou"
}

variable "vpc_name" {
   description = "vpc名称"
   default = "iac_foo"
}

variable "ip_protocol" {
   description = "IP协议"
   default = "tcp"
}

variable "instance_number" {
   description = "云主机数量"
   default = "3"
}

variable "instance_type" {
   description = "实例类型"
   default = "ecs.n2.small"
}

variable "system_disk_category" {
   description = "磁盘类型"
   default = "cloud_ssd"
}

