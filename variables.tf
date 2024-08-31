variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "Standard_B1s"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vnet_cidr" {
  description = "CIDR block for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type        = string
  default     = "BOB"
}
