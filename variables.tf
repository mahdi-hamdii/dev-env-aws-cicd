variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "default VPC ID"
  default     = "vpc-0425a48a4ec05fc5f"
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
