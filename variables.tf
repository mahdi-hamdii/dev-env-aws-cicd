variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-3"
}

variable "vpc_id" {
  type        = string
  description = "default VPC ID"
  default     = "vpc-038a5336a2f78db83"
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
