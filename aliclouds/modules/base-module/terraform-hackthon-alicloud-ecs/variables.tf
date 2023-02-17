variable "vpc_name" {
  description = "vpc"
  type        = string
}

variable "cidr_block" {
  description = "cidr_block"
  type        = string
}


variable "cidr_block_vsw" {
  description = "cidr_block_vsw"
  type        = string
}

variable "availability_zone" {
  description = "可用区域"
  type        = string
}

variable "security_group_name" {
  description = "安全组名字"
  type        = string
}

variable "security_group_rule_type" {
  description = "安全组规则类型"
  type        = string
}

variable "security_group_rule_ip_protocol" {
  description = "安全组ip协议"
  type        = string
}

variable "security_group_rule_nic_type" {
  description = "网卡类型"
  type        = string
}

variable "security_group_rule_policy" {
  description = "安全组策略"
  type        = string
}

variable "security_group_rule_port_range" {
  description = "安全组端口范围"
  type        = string
}

variable "security_group_rule_priority" {
  description = "安全组优先权"
  type        = number
}

variable "security_group_rule_cidr_ip" {
  description = "子网掩码ip"
  type        = string
}

variable "cpus" {
  description = "CPU核数"
  type        = number
}

variable "memory" {
  description = "内存大小"
  type        = number
}

variable "band_width" {
  description = "带宽"
  type = number
}

variable "instance_password" {
  description = "实例密码"
  sensitive = true
  type = string
}
variable "disk_size" {
  description = "磁盘容量"
  type        = string
}

variable "system_disk_category" {
  description = "系统磁盘策略"
  type        = string
}
variable "image_id" {
  description = "ecs 镜像id"
  type        = string
}
variable "instance_name" {
  description = "实例的名称"
  type        = string
}

variable "private_ip" {
  description = "指定私有IP,默认为空时不指定。"
  type        = string
}

variable "instance_charge_type" {
  description = "实例计费方式"
  type        = string
}

variable "public_key" {
  description = "公钥"
  type = string

}