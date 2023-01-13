# 使用CloudIaC Registry的Provider
terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.78.4"
    }
    ansible = {
      source = "nbering/ansible"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}