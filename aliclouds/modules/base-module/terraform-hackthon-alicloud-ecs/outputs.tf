output "private_ip" {
  value = alicloud_instance.instance.*.private_ip
}
output "public_ip" {
  value = alicloud_instance.instance.*.public_ip
}