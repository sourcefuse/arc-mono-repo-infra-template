#!/bin/bash

#############################################################################
### variables
#############################################################################
declare -a execute_in_order=(
  "bootstrap"
  "network"
  "aurora"
  "ecr"
  "eks"
#  "ingress"
)

## help
help () {
   printf "Execute terraform plan / apply on single or all directories.\n"
   printf "Execute recursive cleanup on terraform cache.\n"
   printf "\n"
   printf "Syntax: [-h|p|r|C|A|w]\n"
   printf "options:\n"
   printf "h     Print this help menu.\n"
   printf "p     Optional: Execute terraform plan.\n"
   printf "r     Optional: The name of the resource (directory) in the terraform folder.\n"
   printf "C     Optional: Cleanup the terraform cache. Default is \"false\".\n"
   printf "A     Optional: Recursively execute on ALL terraform directories, in the correct order.\n"
   printf "w     Optional: Terraform workspace where the resources are located. Default is \"dev\".\n"
   printf "\n"
}

############################################################################
## args
############################################################################
## defaults
PLAN=false
RESOURCE=""
CLEANUP=false
RECURSIVELY=false
WORKSPACE="dev"

## cli args
while getopts ":hpCAr:w:" option; do
   case $option in
      h) # display help menu
         help
         exit;;
      p) # Execute terraform plan
         PLAN=true;;
      r) # Enter a resource
         RESOURCE=$OPTARG;;
      C) # Cleanup terraform cache
         CLEANUP=true;;
      A) # Recursively execute terraform command on ALL directories
         RECURSIVELY=true;;
      w) # Enter a workspace
         WORKSPACE=$OPTARG;;
      \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

#############################################################################
### functions
#############################################################################
## init, plan, apply
tf_init () {
  backend_config_file="$(find $workdir -maxdepth 1 -type f -iname *.$WORKSPACE.hcl)"

  if [[ -f "$backend_config_file" ]]; then
    terraform init -backend-config $backend_config_file

  else
    printf "$backend_config_file does not exist.\n"
  fi
}

tf_plan () {
  resource=$1
  tf_data=$PWD/tf-data

  mkdir -p $tf_data

  terraform plan -out $tf_data/$resource.tfplan
  terraform show -no-color -json $tf_data/$resource.tfplan > tempplan.$resource.json

  cat tempplan.$resource.json | python3 -m json.tool > $tf_data/$resource.tfplan.json
  rm -rf tempplan.$resource.json
}

tf_apply () {
  :
#  terraform apply "path_to_tfplan"
}

## terraform recursive
tf_recursive () {
  basedir=$PWD/terraform
  for r in ${execute_in_order[@]}; do
    workdir=$basedir/$r
    printf "\n\nWorking directory: $workdir\n\n"

    cd $workdir

    ## init, select workspace, plan
    ## TODO - add workspace check before selecting workspace
    tf_init
    terraform workspace select $WORKSPACE

    tf_plan $r
  done
}

## cleanup
tf_clear_cache () {
  dot_terraform="$(find $PWD/terraform -type d -name .terraform)"
  tf_data="$(find $PWD/terraform -type d -name tf-data)"

  shopt -s dotglob
  if [ -d -a "$dot_terraform" ] || [ -d -a "$tf_data" ]; then
    if [ -d -a "$dot_terraform" ]; then
      find $dot_terraform -prune -type d | while IFS= read -r d; do
        printf "Removing: $d\n"
        rm -rf "$d"
      done
    fi

    if [ -d -a "$tf_data" ]; then
      find $tf_data -prune -type d | while IFS= read -r d; do
        printf "Removing: $d\n"
        rm -rf "$d"
      done
    fi

    printf "\n"
    printf "Successfully removed all terraform cache.\n"

  else
    printf "Terraform cache not found.\n"
  fi
}

#############################################################################
### main
#############################################################################
main () {
  if [[ -n "$RESOURCE" && $PLAN == true ]]; then
    workdir="$PWD/terraform/$RESOURCE"

    printf "\n\nWorking directory: $workdir\n\n"

    cd $workdir

    ## init and select workspace
    tf_init
    terraform workspace select $WORKSPACE

    ## plan
    tf_plan $RESOURCE
  fi

  if [ $RECURSIVELY == true ]; then
      tf_recursive
  fi

  if [ $CLEANUP == true ]; then
    tf_clear_cache
  fi
}

main
