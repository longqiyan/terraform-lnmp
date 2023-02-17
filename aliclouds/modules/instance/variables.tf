variable "region" {
  description = "地域"
  type = string
  default = "cn-hangzhou"
}
variable "vpc_name" {
  description = "vpc"
  type        = string
  default     = "cloudiac_test"
}

variable "cidr_block" {
  description = "cidr_block"
  type        = string
  default     = "172.16.0.0/12"
}

variable "cidr_block_vsw" {
  description = "cidr_block"
  type        = string
  default     = "172.16.0.0/21"
}

variable "security_group_name" {
  description = "安全组名字"
  type        = string
  default     = "cloudiac_test"
}

variable "security_group_rule_type" {
  description = "安全组规则类型"
  type        = string
  default     = "ingress"
}

variable "security_group_rule_ip_protocol" {
  description = "安全组ip协议"
  type        = string
  default     = "tcp"
}

variable "security_group_rule_nic_type" {
  description = "网卡类型"
  type        = string
  default     = "intranet"
}

variable "security_group_rule_policy" {
  description = "安全组策略"
  type        = string
  default     = "accept"
}

variable "security_group_rule_port_range" {
  description = "安全组端口范围"
  type        = string
  default     = "1/65535"
}

variable "security_group_rule_priority" {
  description = "安全组优先权"
  type        = number
  default     = 1
}

variable "security_group_rule_cidr_ip" {
  description = "子网掩码ip"
  type        = string
  default     = "0.0.0.0/0"
}

variable "cpus" {
  description = "CPU核数,默认为1"
  type        = number
  default     = 1
}

variable "memory" {
  description = "内存大小,默认为2"
  type        = number
  default     = 2
}
variable "band_width" {
  description = "最大带宽"
  type = number
  default = 10
}
variable "image_id" {
  description = "ecs 镜像id"
  type        = string
  default     = "centos_7_7_x64_20G_alibase_20200426.vhd"
}


variable "instance_number" {
  description = "创建ecs服务器数据量，默认值为一台"
  type        = number
  default     = 1
}

variable "disk_size" {
  description = "磁盘容量"
  type        = string
  default     = "40"
}

variable "system_disk_category" {
  description = "系统磁盘策略"
  type        = string
  default     = "cloud_efficiency"
}

variable "instance_name" {
  description = "实例的名称"
  type        = string
  default = "cloudiac-test"
}
variable "instance_charge_type" {
  description = "实例计费方式"
  type        = string
  default     = "PostPaid"
}

variable "public_key" {
  description = "配置的公钥"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVJ+ZdC9YcP9HT/hNGdRi8KFB/FzGVQRSNktffa9hRaoqii/j21LbpL9rR6kizVxgyBFeO+GeYDT6DpYWEbpbL2+qA/lwT2BuB1kkoqgc2UGfQm177iM2G9jeX3x99v6S22vTHthFCXFl6TpaO0mDZJzgzJnUopvmeFsauWHAtAb2JKhtwztYN8FNrOGdZrjm3DMGgyqwsZzPNseYLr+CxabS40QnzEowrhV8HM+uvjmAnINsU4/OHxc1mVAVfyd5GwmA4b4m/BAAzM5oJk+6E5zdr884eMOL2NWvacmkISEAizvh2z90RobrSTpwlazjbVmJ8Hyoy76lRJVPB6mDavMQWT3TKuLP9ws26e0DN3jeoazURFQ19M+EmaxguHL5u7b4mkcxz8agkzGHU1AUYmg87otfyJfqDoZIZsyXMK0M1i5Gm9oNp6yNO2pIavqzD3pz2/m+aJwbw9FXC6Y43/FcmKjxQP5EobDiwulRCQFGed0N2PiadkGgomWYC318= long@localhost"
}

variable "private_ip" {
  description = "指定私有IP,默认为空时不指定。"
  type        = string
  default = ""
}

variable "availability_zone" {
  description = "可用区域"
  type        = string
  default     = "cn-hangzhou-k"
}
variable "instance_password" {
  description = "实例密码"
  sensitive = true
  type = string
  default = "Yunjikeji#123"
}

#输入参数

variable "app_name" {
  description = "application name"
  type        = string
}
variable "user_password" {
  description = "用户密码"
  sensitive   = true
  type        = string
}
variable "redis_version" {
  description = "Redis版本"
  type = string
}

variable "deploy_mode" {
  description = "部署模式"
  type        = string
}

variable "service_port" {
  description = "服务端口"
  type        = number
}

variable "slave_port" {
  description = "从节点端口"
  type        = number
}


variable "sentinel_port" {
  description = "哨兵模式服务端口"
  type        = number
}

variable "install_path" {
  description = "安装路径"
  type        = string
}

variable "software_name" {
  description = "介质包名称"
  type        = string
}

variable "software_ip" {
  description = "介质服务器IP"
  type        = string
}

variable "software_path" {
  description = "介质存放路径"
  type        = string
}


