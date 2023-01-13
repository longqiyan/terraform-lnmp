//output "home_url" {
//  value = [
//    for index, instance in module.instance :
//    {
//      "home_url" : instance.instance.private_ip,
//    }
//  ]
//}
//
//output "username" {
//  value = "admin"
//}
//
//output "password" {
//  value = "zaq1@WSX"
//}
//
//
//output "public_ip" {
//  value = module.instance.*.instance.public_ip
//}
//
//output "private_ip" {
//  value = module.instance.*.instance.private_ip
//}
//
//output "mysql_db" {
//  value = var.mysql_db
//}
//
//output "msyql_host" {
//  value = var.mysql_host
//}
//
//output "mysql_user" {
//  value = var.mysql_user
//}
//
//output "mysql_password" {
//  value = var.mysql_password
//}
//
//output "env_id" {
//  value = var.cloudiac_env_id
//}
//
//output "random_integer" {
//  value = local.hash
//}
//
//output "storage" {
//  value = tencentcloud_cbs_storage.storage.id
//}