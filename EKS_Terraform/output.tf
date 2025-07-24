  output "cluster_id" {
  value = aws_eks_cluster.kirancgwd.id
}

output "node_group_id" {
  value = aws_eks_node_group.kirancgwd.id
}

output "vpc_id" {
  value = aws_vpc.kirancgwd_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.kirancgwd_subnet[*].id
}
