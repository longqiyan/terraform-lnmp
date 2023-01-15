#虚机参数
variable "account_id" {
  type        = string
  description = " 账号ID"
  default     = "idcos_tx"
}
variable "instance_number" {
  description = " 虚机个数"
  default     = 1
}
variable "zone_id" {
  type        = string
  description = "可用区 id"
  default     = "ap-guangzhou-3"
}
variable "instance_type" {
  description = "实例类型"
  default     = "S5.MEDIUM4"
}
variable "instance_name" {
  type        = string
  description = "实例名称"
  default     = "cloudlego_app"
}
variable "image_id" {
  description = "操作系统镜像 id"
  default     = "img-3la7wgnt"
}
variable "hostname" {
  type        = string
  description = "主机名称"
  default     = null
}
variable "disk_type" {
  type        = string
  description = "系统磁盘类型，可选: CLOUD_PREMIUM,CLOUD_SSD,CLOUD_HSSD"
  default     = "CLOUD_PREMIUM"
}
variable "disk_size" {
  type        = number
  description = "系统磁盘大小, 可选范围  50~1000(G)"
  default     = 50
}

variable "data_disk_type" {
  type        = string
  description = "系统磁盘类型，可选: CLOUD_PREMIUM,CLOUD_SSD,CLOUD_HSSD"
  default     = "CLOUD_SSD"
}
variable "data_disk_size" {
  type        = number
  description = "系统磁盘大小, 可选范围  50~1000(G)"
  default     = 60
}

variable "internet_bandwidth" {
  type        = number
  description = "公网带宽"
  default     = 10
}
variable "internet_charge_type" {
  type        = string
  default     = "TRAFFIC_POSTPAID_BY_HOUR"
  description = "公网流量计费模式，可选: BANDWIDTH_PREPAID/TRAFFIC_POSTPAID_BY_HOUR/BANDWIDTH_POSTPAID_BY_HOUR/BANDWIDTH_PACKAGE"
}
variable "private_ip" {
  type        = string
  description = "指定内网 ip"
  default     = null
}
variable "project_id" {
  type    = number
  default = 0
}
variable "tags" {
  type        = map(string)
  description = "标签"
  default = {
    Application = "Cloudjet"
    Owner       = null
    Environment = null
    EnvId       = null
    CostCenter  = null
    UsedFor     = null
    OfferingId  = null
  }
}

//ansible参数
variable "app_name" {
  default     = "cloudlego"
  description = "application name"
}

variable "cloud_glide_record_image" {}
variable "cloud_jet_schedule_job_image" {}
variable "cloud_glide_workflow_image" {}
variable "cloud_glide_web_image" {}
variable "cloudlego_version" {}

variable "reinitialized_sql" {
  default     = false
  description = "是否重新初始化SQL，默认false"
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

variable "iac_kafka_host" {
  default = ""
}

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

variable "enable_backup" {
  description = "是否开启数据备份恢复"
  default     = "true"
}

variable "max_heap" {
  description = "JET-API服务的最大堆"
  default     = "2g"
}

variable "cloudiac_env_id" {
  default = ""
}

variable "snapshot_id" {
  default = "1"
}

variable "retention_days" {
  default = "3"
}