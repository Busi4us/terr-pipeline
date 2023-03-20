
## Providers Block
provider "aws" {
  region = "us-east-1"
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
 
  ami           = "ami-02f3f602d23f1659d"
  instance_type = "t2.micro"
  key_name = "jenkins"   
  
 tags = {
    Name = "terr-pipeline-Ec2"   
    }
}
