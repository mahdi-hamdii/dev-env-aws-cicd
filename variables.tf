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
