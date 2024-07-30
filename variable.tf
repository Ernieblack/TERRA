

variable "region" {
  type = string
  description = "My Region"
  default = "eu-west-2"
}


variable "vpc-cidr" {
  type = string
  description = "My vpc cidr block"
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
    type = string
    description = "My tenancy"
    default = "default"
}


variable "dns-hostnames" {
    type = bool
    description = "My dns hostnames"
    default = true 
}


variable "dns-support" {
    type = bool
    description = "My dns support"
    default = true
}

variable "pub-sub1" {
    type = string
    description = "My public subnet 1"
    default = "10.0.1.0/24"
}

variable "pub-sub2" {
    type = string
    description = "My public subnet 2"
    default = "10.0.2.0/24"
}

variable "priv-sub1" {
    type = string
    description = "My private subnet 1"
    default = "10.0.3.0/24"
}

variable "priv-sub2" {
    type = string
    description = "My private subnet 2"
    default = "10.0.4.0/24"
}