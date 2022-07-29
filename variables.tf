variable "instance_number" {
  default = 1
}

variable "region" {
  default = "cn-hangzhou"
}

variable "zone" {
  default = "cn-hangzhou-b"
}

variable "key_name" {
  default = "loongcloudiac"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC887FqySkIdq9jODZnV8i4AR12ThZTLnMEOhOa2k3MvUqPYja9CxSpow9SeVxBn9sB037jdwLnPWDLcHbhZtJ0lKyXEbFRHpZp2ZsKVHHJlPF5nXT7yBW05n4HWe1B68qTowmGYd14DdSIEpSkabpljXRqoFebm0vNhQs05O3DZO3nrICkV8IzthvUT5LOutveu7BlO06hfv+x28aGlP2dF5iyJAnk8ArpOKraWS+36MCquDt+De38FWY6eSN9X+spKfondMlQDjQMq6OXFpEewVd7NDrqCRwwnDwUDMn/lojtRfbQcmxZaR5bl6k9P3LZB5mJ9QEsHVOXyo/iBXZl=loongcloudiac"
}

variable "vpc_name" {
    default ="vpc-cloudiac-example-long"
}

variable "cidr_block" {
    default= "192.168.0.0/24"
}

variable "sg_name" {
    default = "web"
  description = "web"
}

variable "instance_type" {
    default = "ecs.n2.small"
  description = "ecs.n2.small"
}

variable "instance_name" {
    default = "iac_test-ecs"
  description = "iac_test-ecs"
}