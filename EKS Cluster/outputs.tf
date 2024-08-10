output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public Subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private Subnets"
  value       = module.vpc.private_subnets
}

output "eks_cluster_id" {
  description = "EKS Cluster ID"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_version" {
  description = "EKS Cluster Version"
  value       = module.eks.cluster_version
}

output "eks_node_group_role_arn" {
  description = "EKS Node Group Role ARN"
  value       = module.eks.node_groups_role_arn
}
