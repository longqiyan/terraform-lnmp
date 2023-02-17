variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}



variable "app_name" {
  description = "application name"
  type        = string
}

variable "deploy_mode" {
  description = "部署模式"
  type        = string
  default     = "single"
}

variable "service_port" {
  description = "服务端口"
  type        = number
  default     = 6379
}

variable "slave_port" {
  description = "从节点端口"
  type        = number
  default     = 7001
}


variable "sentinel_port" {
  description = "哨兵模式服务端口"
  type        = number
  default     = 16379
}

variable "install_path" {
  description = "安装路径"
  type        = string
  default     = "/usr/local/redis"
}
variable "software_name" {
  description = "介质包名称"
  type        = string
  default = "redis-5.0.9.tar.gz  "
}

variable "software_ip" {
  description = "介质服务器IP"
  type        = string
  default     = "127.0.0.1"
}

variable "software_path" {
  description = "介质存放路径"
  type        = string
  default     = "soft/redis"
}


variable "user_password" {
  description = "用户密码"
  sensitive   = true
  type        = string
  default = "12345678"
}
variable "redis_version" {
  description = "Redis版本"
  type        = string
  default     = "5.0.9"
}