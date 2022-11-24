# Creating Variable and pass the default value for the cidr block for VPC Creation

variable "cidr-block" {
  default     = "10.0.0.0/16"
  description = "VPC-cidr"
  type        = string
}


# Creating Variable and pass the default value for the cidr block for Public Subnet 1
variable "public-subnet-1a" {
  default     = "10.0.0.0/24"
  description = "VPC-Pub-Subnet-1"
  type        = string
}

# Creating Variable and pass the default value for the cidr block for Public Subnet 2
variable "public-subnet-2a" {
  default     = "10.0.1.0/24"
  description = "VPC-Pub-Subnet-2"
  type        = string
}

# Creating Variable and pass the default value for the cidr block for Private Subnet 1
variable "private-subnet-1a" {
  default     = "10.0.2.0/24"
  description = "VPC-Pri-Subnet-1"
  type        = string
}

# Creating Variable and pass the default value for the cidr block for Private Subnet 2
variable "private-subnet-2a" {
  default     = "10.0.3.0/24"
  description = "VPC-Pri-Subnet-2"
  type        = string
}

# Creating Variable and pass the default value for the cidr block for Private Subnet 3
variable "private-subnet-3a" {
  default     = "10.0.4.0/24"
  description = "VPC-Pri-Subnet-3"
  type        = string
}

# Creating Variable and pass the default value for the cidr block for Private Subnet 4
variable "private-subnet-4a" {
  default     = "10.0.5.0/24"
  description = "VPC-Pri-Subnet-4"
  type        = string
}


