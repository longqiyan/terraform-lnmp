module "redis" {
  source            = "./modules/instance"
  app_name          = var.app_name
  deploy_mode       =var.deploy_mode
  service_port      =var.service_port
  slave_port        =var.slave_port
  sentinel_port     =var.sentinel_port
  install_path      =var.install_path
  software_name     =var.software_name
  software_ip       =var.software_ip
  software_path     =var.software_path
  redis_version = var.redis_version
  user_password = var.user_password
}
