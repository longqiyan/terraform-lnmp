output "home_url" {
  value = [
    for index, instance in alicloud_pvtz_zone_record.foo :
    {
      "home_url" : format("%s.%s", alicloud_pvtz_zone_record.foo[index].rr, var.private_zone ),
    }
  ]
}

output "username" {
  value = "admin"
}

output "password" {
  value = "zaq1@WSX"
}


output "public_ip" {
  value = alicloud_instance.instance.*.public_ip
}

output "private_ip" {
  value = alicloud_instance.instance.*.private_ip
}

output "mysql_db" {
  value = var.mysql_db
}

output "msyql_host" {
  value = var.mysql_host
}

output "mysql_user" {
  value = var.mysql_user
}

output "mysql_password" {
  value = var.mysql_password
}

output "env_id" {
  value = var.cloudiac_env_id
}

output "random_integer" {
  value = local.hash
}

output "disk_id" {
  value = alicloud_ecs_disk.test_disk.id
}