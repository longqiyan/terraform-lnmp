data "alicloud_instance_types" "default" {
  cpu_core_count = var.cpus
  memory_size    = var.memory
}
data "alicloud_zones" "default" {
  available_disk_category     = var.system_disk_category
  available_resource_creation = "VSwitch"
}
//阿里云上创建 VPC、vSwitch、安全组、ECS实例
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = var.cidr_block_vsw
  zone_id    = data.alicloud_zones.default.zones[0].id
}

resource "alicloud_security_group" "default" {
  name   = var.security_group_name
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  security_group_id = alicloud_security_group.default.id
  type              = var.security_group_rule_type
  ip_protocol       = var.security_group_rule_ip_protocol
  nic_type          = var.security_group_rule_nic_type
  policy            = var.security_group_rule_policy
  port_range        = var.security_group_rule_port_range
  priority          = var.security_group_rule_priority
  cidr_ip           = var.security_group_rule_cidr_ip
}

//resource "alicloud_key_pair" "key_pair" {
//  key_pair_name = "test-x"
//  public_key = var.public_key
//}
//
//resource "alicloud_key_pair_attachment" "test" {
//  instance_ids = [alicloud_instance.instance.id]
//  key_pair_name = alicloud_key_pair.key_pair.key_pair_name
//}

resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones[0].id
  
  instance_name              = var.instance_name
  instance_type              = data.alicloud_instance_types.default.instance_types.0.id
  image_id                   = var.image_id
  private_ip                 = var.private_ip
  key_name = "loong-tx"
  internet_max_bandwidth_out = var.band_width
  system_disk_category       = var.system_disk_category
  system_disk_size           = var.disk_size
  security_groups            = alicloud_security_group.default.*.id
  vswitch_id                 = alicloud_vswitch.vsw.id
  instance_charge_type = var.instance_charge_type
}
