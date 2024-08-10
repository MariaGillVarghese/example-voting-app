module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "development-eks-cluster"
  cluster_version = "1.27"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 3
      min_capacity     = 3

      instance_type = "t3.medium"
      key_name      = "your-key-name"
    }
  }

  tags = {
    Name = "development-eks-cluster"
  }
}

output "cluster_name" {
  description = "EKS Cluster name"
  value       = module.eks.cluster_id
}

output "kubeconfig" {
  description = "Kubeconfig"
  value       = module.eks.kubeconfig
}

output "region" {
  description = "AWS Region"
  value       = module.eks.region
}

output "node_group_role_arn" {
  description = "Node group role ARN"
  value       = module.eks.node_groups_role_arn
}
