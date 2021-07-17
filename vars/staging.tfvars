
### Project Meta
meta = {
  environment  = "staging"
  project_name = "WordPress Deployment"
  project_slug = "terraform"
  project_tags = {
    "Developer" : "Muhammet Arslan",
  }
}

## Networking Service
networking_module = {
  enabled = true

  vpc = {
    cidr                 = "10.0.0.0/20"
    enable_dns_hostnames = true
    enable_dns_support   = true
  }

  public_subnet = {
    cidr = ["10.0.0.0/23", "10.0.2.0/23", "10.0.4.0/23"]
  }

  private_subnet = {
    cidr = ["10.0.10.0/23", "10.0.12.0/23", "10.0.14.0/23"]
  }

  nat = {
    enabled            = true
    single_nat_gateway = false
    reuse_nat_ips      = true
  }
}


## APPS
apps = {
  wordpress = {

    enabled = true

    autoscaling = {
      minimum = 1
      desired = 1
      maximum = 1
    }

    ec2 = {
      ami_id        = "ami-00399ec92321828f5"
      instance_size = "t2.micro"
      key_pair      = "wordpress"
    }

    rds = {
      allocated_storage = 100
      storage_type      = "gp2"
      engine            = "mysql"
      engine_version    = "5.7"
      instance_class    = "db.t2.micro"
      multi_az          = true
      database_name     = "wordpress"
      database_username = "wordpress"
    }

  }
}