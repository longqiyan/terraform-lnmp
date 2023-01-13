output "home_url" {
  value = [
    for index, instance in tencentcloud_instance.foo :
    {
      "home_url" : tencentcloud_instance.foo[index].private_ip,
    }
  ]
}

output "username" {
  value = "admin"
}

output "password" {
  value = "zaq1@WSX"
}
//
//
output "public_ip" {
  value = tencentcloud_instance.foo.*.public_ip
}

output "private_ip" {
  value = tencentcloud_instance.foo.*.private_ip
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
//
//output "storage" {
//  value = tencentcloud_cbs_storage.storage.id
//}

output "disk" {
  value = tencentcloud_instance.foo.*.data_disks
}