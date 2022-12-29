terraform {
  required_providers {
    ansible = {
      source = "idcos/ansible"
      version = "1.0.0"
    }
    alicloud = {
      source = "aliyun/alicloud"
      version = "1.124.3"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
    ydd = {
      source  = "store.cloudiac.org/idcos/ydd"
      version = "1.0.2"
    }
  }
}

