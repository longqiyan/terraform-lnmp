module "account" {
  //source为对应module的资源查询的代码存放地址
  source     = "git::https://gitlab.yun.shop/iac-module/terraform-ydd-account.git//modules/tencentcloud-account"
  account_id = var.account_id
}

module "networking" {
  //source为对应module的资源查询的代码存放地址
  source     = "git::https://gitlab.yun.shop/iac-module/terraform-ydd-account.git//modules/tencentcloud-networking"
  account_id = var.account_id
}

module "instance"  {
  //source为对应module的虚拟机创建的代码存放地址
  source = "git::https://gitlab.yun.shop/iac-module/terraform-tencentcloud-modules.git//modules/instance?ref=v0.1.0"
  count  = var.instance_number

  zone_id         = var.zone_id
  vpc_id          = module.networking.vpc.vpc_id
  subnet_id       = module.networking.subnets.public.subnet_id
  security_groups = module.networking.security_groups.public.security_group_id
  keypair_ids     = module.account.kye_pair.key_id
  instance_type = var.instance_type
  instance_name = var.instance_name
  image_id      = var.image_id
  hostname      = var.hostname

  disk_type  = var.disk_type
  disk_size  = var.disk_size
  data_disks = var.data_disks

  internet_bandwidth   = var.internet_bandwidth
  internet_charge_type = var.internet_charge_type
  private_ip           = var.private_ip

  project_id = var.project_id
  tags       = var.tags
}

//resource "tencentcloud_instance" "foo" {
//
//  availability_zone         = var.zone_id
//  vpc_id          = module.networking.vpc.vpc_id
//  subnet_id       = module.networking.subnets.public.subnet_id
//  security_groups = [module.networking.security_groups.public.security_group_id]
//  keypair_ids     = module.account.kye_pair.key_id
//  instance_type = var.instance_type
//  instance_name = var.instance_name
//  key_ids       = [module.account.kye_pair.key_id]
//  private_ip           = var.private_ip
//  internet_max_bandwidth_out   = var.internet_bandwidth
//  internet_charge_type = var.internet_charge_type
//  image_id      = var.image_id
//  hostname      = var.hostname
//  system_disk_type   = var.disk_type
//  system_disk_size          = var.disk_size
//  allocate_public_ip         = var.internet_bandwidth > 0 ? true : false
//
//  data_disks {
//    data_disk_type = "CLOUD_SSD"
//    data_disk_size = 60
//    data_disk_snapshot_id = var.snapshot_id == "1" ? "" : var.snapshot_id
//  }
//  project_id = var.project_id
//  tags       = var.tags
//}

locals {
  hash = substr(parseint(sha1(var.cloudiac_env_id), 16), 0, 6)
}

resource "ansible_host" "cloudlego" {
  count              = var.instance_number
  inventory_hostname = var.internet_bandwidth >= 1 ? module.instance[count.index].instance.public_ip : module.instance[count.index].instance.private_ip
  groups             = [format("%s", var.app_name)]

  vars = {
    wait_connection_timeout = 600
    public_ip               = module.instance[count.index].instance.public_ip
    private_ip              = module.instance[count.index].instance.private_ip

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

resource "tencentcloud_cbs_storage" "storage" {
  availability_zone = var.zone_id
  storage_size    = 60
  force_delete   =true
  storage_name    =  "test"
  storage_type = "CLOUD_SSD"
  // 如果查询不到 snapshot，这里的 id 值是 null
  snapshot_id       = var.snapshot_id == "1" ? "" : var.snapshot_id
}

resource "tencentcloud_cbs_storage_attachment" "attachment" {
  storage_id  = tencentcloud_cbs_storage.storage.id
  instance_id = module.instance[0].instance.instance_id
}