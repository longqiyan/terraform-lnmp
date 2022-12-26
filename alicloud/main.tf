//根据资源组名称查询资源组
module "account" {
  //source为对应module的资源查询的代码存放地址
  source     = "git::https://gitlab.yun.shop/iac-module/terraform-ydd-account.git//modules/alicloud-account?ref=v1.0.0"
  account_id = var.account_id
}

module "networking" {
  //source为对应module的资源查询的代码存放地址
  source     = "git::https://gitlab.yun.shop/iac-module/terraform-ydd-account.git//modules/alicloud-networking?ref=v1.0.0"
  account_id = var.account_id
}
#//根据资源组名称查询资源组
#data "alicloud_resource_manager_resource_groups" "rmrg" {
#  ids = [var.resource_group_id]
#}
#
#//根据资源组id查询vpc
#data "alicloud_vpcs" "vpcs2" {
#  ids = [var.vpc_id]
#}
#
#//根据资源组id查询vswitch
#data "alicloud_vswitches" "vsws" {
#  #  zone_id           = var.availability_zone
#  vpc_id       = var.vpc_id
#  vswitch_name = var.vswitch_name
#}
#//根据vpc id查询安全组
#data "alicloud_security_groups" "sgs" {
#  #  name_regex        = "allow_internal"
#  #  ids               = [var.security_group_id]
#  #  vpc_id            = data.alicloud_vpcs.vpcs2.vpcs.0.id
#  resource_group_id = data.alicloud_resource_manager_resource_groups.rmrg.groups.0.id
#}
#
#//查询密钥对
#data "alicloud_ecs_key_pairs" "ekps" {
#  name_regex = var.key_name
#}
resource "alicloud_instance" "instance" {
  count                      = var.instance_number
  availability_zone          = module.networking.vswitches.private.zone_id
  security_groups            = [module.networking.security_groups.private.id]
  instance_type              = var.instance_type
  spot_strategy              = var.create_spot_instance ? "SpotAsPriceGo" : "NoSpot"
  spot_price_limit           = 0
  system_disk_category       = "cloud_efficiency"
  system_disk_size           = var.disk_size
  image_id                   = var.image_id
  instance_name              = var.instance_name
  vswitch_id                 = module.networking.vswitches.private.vswitch_id
  # 设置带宽大于1， 则自动分配公网IP
  internet_max_bandwidth_out = var.bandwidth_out
  key_name                   = module.account.key_pair.id
  resource_group_id          = module.networking.resource_group.id
  private_ip                 = length(var.private_ip) > 0 ? var.private_ip : ""
  tags                       = {
    application = var.tags_application
    owner       = var.tags_owner
  }
  volume_tags = {
    application = var.tags_application
    owner       = var.tags_owner
  }
}

resource "ansible_host" "cloudlego" {
  count              = var.instance_number
  inventory_hostname = var.bandwidth_out >= 1 ? alicloud_instance.instance[count.index].public_ip : alicloud_instance.instance[count.index].private_ip
  groups             = [format("%s", var.app_name)]

  vars = {
    wait_connection_timeout = 600
    public_ip               = alicloud_instance.instance[count.index].public_ip
    private_ip              = alicloud_instance.instance[count.index].private_ip

    cloud_glide_record_image     = var.cloud_glide_record_image
    cloud_jet_schedule_job_image = var.cloud_jet_schedule_job_image
    cloud_glide_workflow_image   = var.cloud_glide_workflow_image
    cloud_glide_web_image        = var.cloud_glide_web_image
    cloudlego_version            = var.cloudlego_version
    reinitialized_sql            = var.reinitialized_sql

    // mysql备份
    oss_address = var.oss_address
    oss_ak      = var.oss_ak
    oss_sk      = var.oss_sk
    is_backup   = var.is_backup

    //消息消费
    iac_kafka_host     = var.iac_kafka_host
    iac_kafka_user     = var.iac_kafka_user
    iac_kafka_password = var.iac_kafka_password
    consumer_group_id  = var.consumer_group_id

    //对象存储
    io_type              = var.io_type
    io_endpoint          = var.io_endpoint
    io_access_key_id     = var.io_access_key_id
    io_access_key_secret = var.io_access_key_secret
    io_bucket            = var.io_bucket

    //mysql_host
    mysql_host     = var.mysql_host
    mysql_db       = var.mysql_db
    mysql_user     = var.mysql_user
    mysql_password = var.mysql_password

    enable_backup  = var.enable_backup

    //最大堆
    max_heap = var.max_heap
  }
}

resource "random_integer" "this" {
  min     = 100000
  max     = 999999
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    listener_arn = "idcos-jet"
  }
}

data "alicloud_pvtz_zones" "pvtz_zones_ds" {
  keyword = var.private_zone
}

locals {
  hash = substr(parseint(sha1(var.cloudiac_env_id), 16), 0, 6)
}

resource "alicloud_pvtz_zone_record" "foo" {
  count   = var.private_zone_domain == "" ? 0 : var.instance_number
  zone_id = data.alicloud_pvtz_zones.pvtz_zones_ds.zones.0.id
  rr      = var.instance_number > 1 ? "${var.private_zone_domain}${count.index}${local.hash}" : "${var.private_zone_domain}${local.hash}"
  type    = "A"
  value   = alicloud_instance.instance[count.index].private_ip
  ttl     = 60
}

locals {
  // snapshot_name 需要保证唯一
  snapshot_name = "snapshot-cloudjet-disk1-${var.cloudiac_env_id}"
}

data "ydd_disk_snapshot_alicloud" "ss" {
  disk_number = 1
  // 这里只传入一个 snapshot name, 查询快照时自动添加序号后缀组成完整名称，
  // 如 "snapshot-appname-disk1-xxxx-001"
  snapshot_name = local.snapshot_name
  resource_group_id    = module.networking.resource_group.id
}

resource "alicloud_ecs_disk" "test_disk" {
  zone_id = module.networking.vswitches.private.zone_id
  size    = "60"
  category = "cloud_essd"
  // 如果查询不到 snapshot，这里的 id 值是 null
  snapshot_id       = data.ydd_disk_snapshot_alicloud.ss.snapshots[0].id
  resource_group_id    = module.networking.resource_group.id
}

resource "alicloud_ecs_disk_attachment" "test_disk_att" {
  disk_id     = alicloud_ecs_disk.test_disk.id
  instance_id = alicloud_instance.instance[0].id
}

resource "ydd_disk_snapshot_alicloud" "test_disk_snapshot" {
  disk_ids = [alicloud_ecs_disk.test_disk.id]
  resource_group_id    = module.networking.resource_group.id

  // 这里只传入一个 snapshot name, 创建快照时自动按序号添加后缀，
  // 如 "snapshot-appname-disk1-xxxx-001"
  snapshot_name = local.snapshot_name

  // 自动备份策略，
  // 可选: on_destroy, X hour[s], X day[s], X week[s], X month[s]
  // 暂时只实现 on_destroy，且为默认值
  auto_policy = "on_destroy"
  # auto_policy = retention_days == "true" ? "on_destroy" : ""

  // 快照保留天数，默认永久保留
  retention_days = var.snapshot_retention_days
}