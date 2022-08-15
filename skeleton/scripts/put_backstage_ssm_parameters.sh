#!/bin/bash
environment=$1
profile=$2
region=$3
namespace=$4

aws ssm put-parameter --name "/$namespace/$environment/backstage/github_token" --value "$github_token" --type=SecureString --region "$region" --overwrite --profile="$profile"
aws ssm put-parameter --name "/$namespace/$environment/backstage/github_client_id" --value "$github_client_id" --type=SecureString --region "$region" --overwrite --profile="$profile"
aws ssm put-parameter --name "/$namespace/$environment/backstage/github_client_secret" --value "$github_client_secret" --type=SecureString --overwrite --region "$region" --profile="$profile"
