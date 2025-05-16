variable "aws_access_key" {
    type        = string
    description = "AWS Access Key"
    sensitive   = true
}

variable "aws_secret_key" {
    type        = string
    description = "AWS Secret Key"
    sensitive   = true
}

variable "aws_region" {
    type        = string
    description = "Which AWS region"
    default     = "us-east-1"
}

variable "aws_instance_type" {
    type        = string
    description = "AWS instance type"
    default     = "t2.micro"
}

variable "aws_vpc_cidr_block" {
    type        = string
    description = "CIDR range"
    default     = "10.0.0.0/16"
}

variable "aws_subnet_cidr_block" {
    type        = string
    description = "CIDR range"
    default     = "10.0.0.0/24"
}

variable "enable_dns_hostnames" {
    type        = bool
    description = "Enable DNS hostname"
    default     = true
}

variable "map_public_ip_on_launch" {
    type        = bool
    description = "Enable public ip"
    default     = true
}

variable "ingress_from_port" {
    type        = number
    description = "Number"
    default     = 80
}

variable "ingress_to_port" {
    type        = number
    description = "Number"
    default     = 80
}

variable "ingress_protocol" {
    type        = string
    description = "Ingress Protocol"
    default     = "tcp"
}

variable "egress_from_port" {
    type        = number
    description = "Number"
    default     = 0
}

variable "egress_to_port" {
    type        = number
    description = "Number"
    default     = 0
}

variable "egress_protocol" {
    type        = string
    description = "Ingress Protocol"
    default     = "-1"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "Globomantics"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}