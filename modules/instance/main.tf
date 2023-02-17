module "ecs_instance" {
  source                          = "../base-module/terraform-hackthon-alicloud-ecs"
  vpc_name                        = var.vpc_name
  security_group_name             = var.security_group_name
  instance_name                   = var.instance_name
  disk_size                       = var.disk_size
  cpus                            = var.cpus
  memory                          = var.memory
  band_width                      = var.band_width
  image_id                        = var.image_id
  system_disk_category            = var.system_disk_category
  security_group_rule_ip_protocol = var.security_group_rule_ip_protocol
  security_group_rule_policy      = var.security_group_rule_policy
  security_group_rule_type        = var.security_group_rule_type
  security_group_rule_port_range  = var.security_group_rule_port_range
  security_group_rule_cidr_ip     = var.security_group_rule_cidr_ip
  instance_password               = var.instance_password
  public_key = var.public_key
  availability_zone = var.availability_zone
  cidr_block = var.cidr_block
  cidr_block_vsw = var.cidr_block_vsw
  instance_charge_type = var.instance_charge_type
  private_ip = var.private_ip
  security_group_rule_nic_type = var.security_group_rule_nic_type
  security_group_rule_priority = var.security_group_rule_priority
}

resource "ansible_host" "redis" {
  count = var.instance_number
  // 配置机器的 hostname，一般配置为计算资源的 public_ip (或 private_ip)
  inventory_hostname = module.ecs_instance.public_ip[count.index]
  // 配置机器所属分组
  groups = [format("%s",var.app_name)]
  // 传给 ansible 的 vars，可在 playbook 文件中引用
  vars = {
    wait_connection_timeout = 600
    redis_version     = var.redis_version
    deploy_mode       =var.deploy_mode
    service_port      =var.service_port
    slave_port        =var.slave_port
    sentinel_port     =var.sentinel_port
    install_path      =var.install_path
    software_name     =var.software_name
    software_ip       =var.software_ip
    software_path     =var.software_path
    user_password     = var.user_password
  }
}