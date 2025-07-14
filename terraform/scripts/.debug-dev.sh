#!/bin/bash

# The env to use
source ./scripts/.env

# export SUBID
export ARM_SUBSCRIPTION_ID="${SUBSCRIPTION_ID}"
export ARM_CLIENT_SECRET="${CLIENT_SECRET}"
export ARM_TENANT_ID="${TENANT_ID}"
export ARM_CLIENT_ID="${CLIENT_ID}"
export CLOUDFLARE_API_TOKEN="${CLOUDFLARE_API_TOKEN}"

# export Variables
export TF_VAR_application_name="${APPLICATION_NAME}"
export TF_VAR_environment_name="${ENVIRONMENT_NAME}"
export TF_VAR_cloudflare_account_id="${CLOUDFLARE_ACCOUNT_ID}"


export BACKEND_RESOURCE_GROUP_NAME="${BACKEND_RG_NAME}"
export BACKEND_STORAGE_ACCOUNT_NAME="${BACKEND_STORAGE_ACCOUNT_NAME}"
export BACKEND_CONTAINER_NAME="${BACKEND_CONTAINER_NAME}"
export BACKEND_KEY="key-${TF_VAR_application_name}-${TF_VAR_environment_name}.tfstate"

terraform init \
  -backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP_NAME}" \
  -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT_NAME}" \
  -backend-config="container_name=${BACKEND_CONTAINER_NAME}" \
  -backend-config="key=${BACKEND_KEY}" \

terraform $*


