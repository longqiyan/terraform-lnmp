resource "alicloud_vpc" "vpc_test" {
  vpc_name   = "cloudiac_test"
  cidr_block = "172.16.0.0/12"
}

data "alicloud_vpcs" "show_vpc" {
  name_regex = "^foo"
}

terraform {
  required_providers {
    alicloud = {
      source = "hashicorp/alicloud"
      version = "1.185.0"
    }
  }
}

output "redis_server" {
  value = data.alicloud_vpcs.show_vpc
}