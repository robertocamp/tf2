#############################################################
##
## This app file contains the Main installation flows for 
## AWS-Terraform-Workshop
## 
## @package /aws-terraform-workshop
## @year 2019
## @author Muhammet Arslan <muhammet.arsln@gmail.com>
## @url https://medium.com/muhammet-arslan
## @repo https://github.com/geass/aws-terraform-workshop
##
#############################################################

provider "aws" {
  region = "us-east-2"
}

## Networking
module "networking" {
  source = "./modules/networking/"

  ## Networking Service
  networking_module = var.networking_module

  ## Meta
  meta = var.meta
}

## APPS
module "apps" {
  source = "./apps"

  ## Networking Service
  networking_module = module.networking

  ## Apps
  apps = var.apps

  ## Meta
  meta = var.meta
}
