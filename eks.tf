module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "genai-eks-cluster"
  cluster_version = "1.32"

  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  eks_managed_node_groups = {

    cpu_nodes = {

      instance_types = ["t3.xlarge"]  ## Use GPU Instance if it is available in your Quota

      desired_size = 3
      min_size     = 2
      max_size     = 4

      ami_type = "AL2023_x86_64_STANDARD"

      capacity_type = "ON_DEMAND"

      disk_size = 50

      labels = {
        role = "cpu"
      }
    }
  }

  tags = {
    Environment = "dev"
    Project     = "genai-platform"
  }
}
