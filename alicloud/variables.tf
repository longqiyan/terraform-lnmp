variable "account_id" {
  default = "idcos-idp"
}

variable "region" {
  default = "cn-hangzhou"
}

variable "tags_application" {
  default = "CloudLego"
}

#variable "availability_zone" {
#  default     = "cn-hangzhou-k"
#  description = "可用区域"
#}

variable "app_name" {
  default     = "cloudlego"
  description = "application name"
}

variable "instance_type" {
  default     = "ecs.c6.large"
  # default     = "ecs.c6.xlarge"
  description = "创建ecs服务器实例规格"
}

variable "image_id" {
  default     = "centos_7_7_x64_20G_alibase_20200426.vhd"
  description = "ecs 镜像id"
}


variable "instance_number" {
  default     = 1
  description = "创建ecs服务器数据量，默认值为一台"
}

variable "bandwidth_out" {
  description = "机器带宽，大于 0 则分配公网ip"
  default     = 0
}

#variable "resource_group_id" {
#  # default     = "test1$"
#  description = "资源组名称"
#}

variable "disk_size" {
  default     = "50"
  description = "磁盘容量"
}

variable "instance_name" {
  default     = "cloudlego_app"
  description = "中实例的名称"
}

variable "public_key" {
  description = "ssh 公钥"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVr+09wfrsUpLyBv6R5AYf+G001zY7a+M9Pe5NVgg7J/2zIFAWssoLVgi1+3qh6sUt+aBe21YKXRrCkFeYbcK9XFnr/PhhZxmYimBrdGkqoWB4LBq4FRP+qn2EazfRx/8ypcRIw7jEVH8Ye8BirY7BJO7LN1n8pmOD03OiwrUeFAwBN6flQcm9ytJGglUXr//SDDYytBpyy9d9umFdRLJ7N3cOyvmHEqqlZzQMwAYiRWKuFmPNxh5jmxenSbQKqAFHD/keNZXVH0H79k6A7wBXPYsjaGwmcuq3ACElIFwcu8J7M8rVnAkSoDJNefIBt0/Vb9LsaUiWGsy+kU6uX4dPotR4DkI7PKnS72Z05o+85iIdtA9T9Zop9P80wXv1ATNJZM9gzeqLEbcUUpUHCrAdPcg2o8raW0bDcaBLXOD2P+PIfXJtF05ntGzl+QF/xZeoOnOT2xsKPziHdZ0F9h+QlcPEL8TVfG5iep39lVOkKPqDM125OlX6WFu7jdjR8p0= admin@lego"
}

#variable "key_name" {
#  default     = "lego_admin$"
#  description = "配置的公钥名称"
#}

variable "reinitialized_sql" {
  default     = false
  description = "是否重新初始化SQL，默认false"
}

variable "cloud_glide_record_image" {}
variable "cloud_jet_schedule_job_image" {}
variable "cloud_glide_workflow_image" {}
variable "cloud_glide_web_image" {}
variable "cloudlego_version" {}
variable "tags_owner" { default = "wanglei" }

variable "private_ip" {
  default     = ""
  description = "指定私有IP，默认为空时不指定。"
}


# oss 配置
variable "oss_address" {
  description = "oss地址"
  type        = string
  default     = "oss-cn-hangzhou-internal.aliyuncs.com"
}

variable "oss_ak" {
  description = "oss access key"
  type        = string
  default     = "LTAI5tHHUSWenVsJ998rG5sE"
}

variable "oss_sk" {
  description = "oss secret key"
  type        = string
  sensitive   = true
  default     = ""
}

variable "is_backup" {
  description = "备份开关"
  type        = bool
  default     = false
}


#variable "vpc_id" {}
#variable "vswitch_id" {}
#variable "vswitch_name" {
#  default = "jet"
#}
#variable "security_group_id" {}

variable "iac_kafka_host" {}

variable "iac_kafka_user" {
  default = "admin"
}
variable "iac_kafka_password" {
  default = "yunjikeji"
}

variable "consumer_group_id" {
  default = "glide_record"
}
variable "io_type" {}
variable "io_endpoint" {}
variable "io_access_key_id" {}
variable "io_access_key_secret" {}
variable "io_bucket" {}
variable "mysql_host" {}
variable "mysql_db" {
  default = "cloud_glide"
}
variable "mysql_user" {
  default = "admin"
}
variable "mysql_password" {
  default = "Yunjikeji#123"
}

variable "private_zone_domain" {}
variable "private_zone" {
  default = "yun.idcos"
}
variable "create_spot_instance" {
  default = true
}
variable "cloudiac_env_id" {
  default = ""
}

variable "snapshot_retention_days" {
  description = "快照保存时间（天）"
  default = "3"
}

variable "enable_backup" {
  description = "是否开启数据备份恢复"
  default = "false"
}

variable "max_heap" {
  description = "JET-API服务的最大堆"
  default = "2g"
}