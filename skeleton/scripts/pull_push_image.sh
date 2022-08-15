aws ecr get-login-password --region us-east-1 --profile sf_ref_arch | docker login --username AWS --password-stdin 757583164619.dkr.ecr.us-east-1.amazonaws.com
aws ecr get-login-password --region us-east-1 --profile refarchprod | docker login --username AWS --password-stdin 915904156741.dkr.ecr.us-east-1.amazonaws.com

docker pull 757583164619.dkr.ecr.us-east-1.amazonaws.com/sf-refarch-dev-sourcefuse-backstage:0.1.3
docker tag 757583164619.dkr.ecr.us-east-1.amazonaws.com/sf-refarch-dev-sourcefuse-backstage:0.1.3 915904156741.dkr.ecr.us-east-1.amazonaws.com/sf-refarch-prod-sourcefuse-backstage:0.1.3
docker push 915904156741.dkr.ecr.us-east-1.amazonaws.com/sf-refarch-prod-sourcefuse-backstage:0.1.3
