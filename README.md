# eks-lab
eks lab

eksctl command
 eksctl create cluster \
> --name test-cluster \
> --version 1.17 \
> --region eu-west-3 \
> --nodegroup-name linux-nodes \
> --node-type t2.micro \
> --nodes 2
