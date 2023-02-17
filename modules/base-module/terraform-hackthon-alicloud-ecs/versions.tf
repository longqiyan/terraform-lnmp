terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
    alicloud = {
      source = "hashicorp/alicloud"
      version = "1.185.0"
    }
  }
}

