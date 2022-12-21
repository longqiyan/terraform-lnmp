provider "alicloud" {
  region = var.region
}

variable "tags_application" { default = "CloudLego" }


//根据资源组名称查询资源组
data "alicloud_resource_manager_resource_groups" "rmrg" {
  ids = [var.resource_group_id]
}

//根据资源组id查询vpc
data "alicloud_vpcs" "vpcs2" {
  ids = [var.vpc_id]
}

//根据资源组id查询vswitch
data "alicloud_vswitches" "vsws" {
  #  zone_id           = var.availability_zone
  vpc_id       = var.vpc_id
  vswitch_name = var.vswitch_name
}
//根据vpc id查询安全组
data "alicloud_security_groups" "sgs" {
  #  name_regex        = "allow_internal"
  #  ids               = [var.security_group_id]
  #  vpc_id            = data.alicloud_vpcs.vpcs2.vpcs.0.id
  resource_group_id = data.alicloud_resource_manager_resource_groups.rmrg.groups.0.id
}

//查询密钥对
data "alicloud_ecs_key_pairs" "ekps" {
  name_regex = var.key_name
}


resource "alicloud_instance" "instance" {
  count                      = var.instance_number
  availability_zone          = var.availability_zone
  # alicloud_security_group.default.*.id 安全组id
  security_groups            = [var.security_group_id]
  instance_type              = var.instance_type
  spot_strategy       = var.create_spot_instance ? "SpotAsPriceGo" : "NoSpot"
  spot_price_limit              = 0
  system_disk_category       = "cloud_efficiency"
  system_disk_size           = var.disk_size
  image_id                   = var.image_id
  instance_name              = var.instance_name
  vswitch_id                 = data.alicloud_vswitches.vsws.vswitches.0.id
  # 设置带宽大于1， 则自动分配公网IP
  internet_max_bandwidth_out = var.bandwidth_out
  key_name                   = data.alicloud_ecs_key_pairs.ekps.key_pairs.0.id
  resource_group_id          = data.alicloud_resource_manager_resource_groups.rmrg.groups.0.id
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
  }
}

resource "random_integer" "this" {
  min = 100000
  max = 999999
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