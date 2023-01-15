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
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    //    null = {
    //      source  = "hashicorp/null"
    //      version = "3.2.1"
    //    }
    tencentbackup = {
      source  = "store.cloudiac.org/idcos/tencentbackup"
      version = "1.0.4"
    }
  }
}