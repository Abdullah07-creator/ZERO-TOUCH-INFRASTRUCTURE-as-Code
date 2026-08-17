
variable "vpc_cidr" {
  type        = string
  description = "Base CIDR block for the Virtual Private Cloud"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for Public Subnet 1"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for Private Subnet 1"
  default     = "10.0.2.0/24"
}

variable "environment" {
  type        = string
  description = "Environment identifier tag"
  default     = "dev"
}