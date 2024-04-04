#!/bin/bash

EXTRA_ARGS=""
plan_id=$(git rev-parse --short "$GITHUB_SHA")
INIT=false
PLAN=false
APPLY=false
ENV=$2
while getopts "hip:a:d:z:" option; do
  case $option in
    h) #show help
    help
    ;;
    i) #initialise backend
    export ENV=$2
    INIT=true
    ;;
    p) #run plan
    export ENV=$OPTARG
    PLAN=true
    ;;
    a) #run apply
    export ENV=$OPTARG
    APPLY=true
    ;;
    d) #set directory
    DIRECTORY=$OPTARG
    ;;
    z) #pass extra arguments
    EXTRA_ARGS=$OPTARG
    ;;
    \?)
    echo "ERROR: Invalid option $option"
    echo "valid options are : [-i|p|a|d]"
    break;
    ;;
  esac
done

cleanup () {
  OPTIND=1
  unset EXTRA_ARGS
  unset DIRECTORY
  unset INIT
  unset PLAN
  unset APPLY
}

help () {
    help () {
   printf "Script to run terraform actions in github actions. Source this with arguments\n"

   printf "\n"
   printf "Syntax: [-h|i|p|a|d|z]\n"
   printf "options:\n"
   printf "h     Print this help menu.\n"
   printf "i     run terraform init\n"
   printf "p     run terraform plan against passed env (requires env as argument)\n"
   printf "a     run terraform apply agaisnt passed env (requires env as argument)\n"
   printf "d     !!REQUIRED!! directory inside terraform/ in this repo to run terraform commands on\n"
   printf "\n"

   printf "examples:\n source rfsmart-env -e dev -t <mfa-auth-key> ##sets parametes and credentials for dev env \n source rfsmart-env -u ##cleans all variables values\n\n"
}
}

check_dir() {
 ! [ -d "terraform/$DIRECTORY" ]
}

init () {
  aws sts get-caller-identity
  cd terraform/$DIRECTORY
  case $ENV in
  "dev")
    terraform init -backend-config backend/config.dev.hcl $EXTRA_ARGS
    ;;
  "prod")
    terraform init -backend-config backend/config.prod.hcl $EXTRA_ARGS
    ;;
  "stg")
    terraform init -backend-config backend/config.stg.hcl $EXTRA_ARGS
    ;;
  *)
    echo "Invalid environment specified. $ENV"
    ;;
esac
  terraform workspace list

}

plan () {

  cd terraform/$DIRECTORY
  PLAN_FILENAME=$ENV-$(basename $DIRECTORY)-$plan_id.tfplan
  terraform plan -var-file=tfvars/$ENV.tfvars $EXTRA_ARGS -out $PLAN_FILENAME
  PLAN_OUTPUT=$(terraform show -no-color $PLAN_FILENAME)
  echo "Terraform plan output for $ENV" >> $ENV-plan-output.txt
  echo "" >> $ENV-plan-output.txt
  echo "\`\`\`text" >> $ENV-plan-output.txt
  echo "" >> $ENV-plan-output.txt
  echo "$PLAN_OUTPUT" >> $ENV-plan-output.txt
  echo "" >> $ENV-plan-output.txt
  echo "\`\`\`" >> $ENV-plan-output.txt
  echo "" >> $ENV-plan-output.txt

}

apply () {

  cd terraform/$DIRECTORY
  terraform apply -auto-approve $EXTRA_ARGS $ENV-$DIRECTORY-$plan_id.tfplan

}

main () {
  if check_dir;
  then
    echo "ERROR: Invalid value for directory : directory $DIRECTORY does not exist within current directory"
  return 1;
  fi

  if [[ ! $ENV =~ ^(backend|dev|ops|prod|stg)$ ]];
  then
    echo "Invalid environment $ENV passed with plan/apply option"
  return
  fi

  if $INIT;
  then
    init
    return $?
  fi

  if $PLAN;
  then
    plan
    return $?
  fi

  if $APPLY;
  then
    apply
    return $?
  fi

}

main
cleanup
