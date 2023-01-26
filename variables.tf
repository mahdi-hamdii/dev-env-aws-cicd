variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-3"
}

variable "vpc_id" {
  type        = string
  description = "default VPC ID"
  default     = "vpc-083836141f53acd48"
}

variable "private_key_path" {
  type        = string
  description = "Private Key for ssh"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "ami_id" {
  type    = string
  default = "ami-0afd55c0c8a52973a"
}
