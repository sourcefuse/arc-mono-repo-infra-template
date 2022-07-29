aws eks update-kubeconfig --name refarchdevops-prod-devops-k8s-cluster --region us-east-1 --profile refarchprod
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
kubectl proxy
