## Networking Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "public subnets"
  value       = module.vpc.public_subnets
}