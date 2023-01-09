#!/bin/bash

#############################################################################
### variables
#############################################################################
declare -a execute_in_order=(
  "network"
  "db"
  "ecr"
  "eks"
)

## help
help () {
   printf "Execute terraform plan / apply on single or all directories.\n"
   printf "Execute recursive cleanup on terraform cache.\n"
   printf "\n"
   printf "Syntax: [-h|p|P|r|C|a|A|w]\n"
   printf "options:\n"
   printf "h     Print this help menu.\n"
   printf "p     Optional: Execute terraform plan.\n"
   printf "P     Optional: Recursively execute plan on ALL terraform directories, in the correct order.\n"
   printf "r     Optional: The name of the resource (directory) in the terraform folder.\n"
   printf "C     Optional: Cleanup the terraform cache. Default is \"false\".\n"
   printf "A     Optional: Execute apply.\n"
   printf "A     Optional: Recursively execute plan and apply on ALL terraform directories, in the correct order.\n"
   printf "w     Optional: Terraform workspace where the resources are located. Default is \"dev\".\n"
   printf "\n"
}

############################################################################
## args
############################################################################
## defaults
PLAN=false
RECURSIVELY_PLAN=false
RECURSIVELY_APPLY=false
APPLY=false
RESOURCE=""
CLEANUP=false
WORKSPACE="dev"

## cli args
while getopts ":hpPCaAr:w:" option; do
   case $option in
      h) # display help menu
         help
         exit;;
      p) # Execute terraform plan
         PLAN=true;;
      P) # Recursively execute terraform plan on ALL directories
         RECURSIVELY_PLAN=true;;
      r) # Enter a resource
         RESOURCE=$OPTARG;;
      C) # Cleanup terraform cache
         CLEANUP=true;;
      a) # execute terraform apply on specified resource
         APPLY=true;;
      A) # Recursively execute terraform apply on ALL directories
         RECURSIVELY_APPLY=true;;
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
tf_init () {
  backend_config_file="$(find $workdir -maxdepth 1 -type f -iname *.$WORKSPACE.hcl)"

  if [[ -f "$backend_config_file" ]]; then
    terraform init -backend-config $backend_config_file

    ## TODO - add workspace check before selecting workspace
    terraform workspace new $WORKSPACE
    terraform workspace select $WORKSPACE

  else
    printf "Backend config file does not exist.\n"
  fi
}

tf_plan () {
  resource=$1
  tf_data=$PWD/tf-data
  var_file_exists="$(find $workdir -maxdepth 1 -type f -iname $WORKSPACE.tfvars )"

  mkdir -p $tf_data

  if [[ -f "$var_file_exists" ]]; then
    printf "Using variable file: $WORKSPACE.tfvars \n"
    terraform plan -var-file=$WORKSPACE.tfvars -out $tf_data/$resource.tfplan

  else
    printf "Variable file not found. Using default variables.\n"
    terraform plan -out $tf_data/$resource.tfplan
  fi

  terraform show -no-color -json $tf_data/$resource.tfplan > tempplan.$resource.json

  cat tempplan.$resource.json | python3 -m json.tool > $tf_data/$resource.tfplan.json
  rm -rf tempplan.$resource.json
}

tf_apply () {
  resource=$1
  tf_data=$PWD/tf-data

  terraform apply -auto-approve $tf_data/$resource.tfplan
}

## terraform recursive
tf_recursive () {
  basedir=$PWD/terraform

  for r in ${execute_in_order[@]}; do
    workdir=$basedir/$r

    printf "\n\n"
    printf "########################################################################################################################################\n"
    printf "##\n"
    printf "## Resource: $r \n"
    printf "## Working directory: $workdir \n"
    printf "##\n"
    printf "########################################################################################################################################\n"
    printf "\n\n"

    cd $workdir

    ## init, select workspace, plan

    if [ $RECURSIVELY_PLAN == true ]; then
      tf_init
      tf_plan $r
    fi

    if [ $RECURSIVELY_APPLY == true ]; then
      tf_init
      tf_apply $r
    fi

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
  if [[ -n "$RESOURCE" && $PLAN == true ]] || [[ -n "$RESOURCE" && $APPLY == true ]]; then
    workdir="$PWD/terraform/$RESOURCE"

    printf "\n\n"
    printf "########################################################################################################################################\n"
    printf "##\n"
    printf "## Resource: $RESOURCE \n"
    printf "## Working directory: $workdir \n"
    printf "##\n"
    printf "########################################################################################################################################\n"
    printf "\n\n"

    cd $workdir

    ## init and select workspace

    ## plan
    if [[ -n "$RESOURCE" && $PLAN == true ]]; then
      tf_init
      tf_plan $RESOURCE
    fi

    ## apply
    if [[ -n "$RESOURCE" && $APPLY == true ]]; then
      tf_apply $RESOURCE
    fi
  fi

  if [ $RECURSIVELY_PLAN == true ] || [ $RECURSIVELY_APPLY  == true ]; then
      tf_recursive
  fi

  if [ $CLEANUP == true ]; then
    tf_clear_cache
  fi
}

main
