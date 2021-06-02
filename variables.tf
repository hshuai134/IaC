
variable "access_key" {
   description = "用户阿里云ak_id信息"
}

variable "secret_key" {
   description = "用户阿里云ak_secret信息"
}

variable "vswitch_availability_zone" {
   description = "交换机可用区域地址"
   default = "cn-beijing-b"
}

variable "region" {
   description = "阿里云服务region名称"
   default = "cn-beijing"
}
