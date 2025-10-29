variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "Global eindeutiger S3 Bucket Name"
}

variable "name_prefix" {
  type    = string
  default = "devops-a4"
}