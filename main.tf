
## Providers Block
provider "aws" {
  region = "us-east-2"
}

terraform {
     required_version = ">=1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# CREATING VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
   
   tags = {
    Name = "Terr-pipeline-vpc"   
}
}

# USING COUNT TO CREATE PUBLIC SUBNETS
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  
  map_public_ip_on_launch = true #public ip

  tags = {
    Name = "terr-pipeline-subnet"   
    }
}

##Creating EC2
resource "aws_instance" "EC2" {
 
  ami           = "ami-00eeedc4036573771"
  instance_type = "t2.micro"
  key_name = "us-east-2"   // "us-east-2" == this is the name of my key pair without the .pem
  
availability_zone = "us-east-2a"
 tags = {
    Name = "terr-pipeline-EC2"   
    }
}
