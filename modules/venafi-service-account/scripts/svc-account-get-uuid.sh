#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Using the terraform way of inputting JSON
# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external#processing-json-in-shell-scripts
eval "$(jq -r '@sh "VCP_CLUSTER_NAME=\(.VCP_CLUSTER_NAME) VCP_API_KEY=\(.VCP_API_KEY)"')"

# Get All ccounts
ALL_ACCOUNTS=$(curl -s --request GET \
  --url https://api.venafi.cloud/v1/serviceaccounts \
  --header 'accept: application/json' \
  --header "tppl-api-key: ${VCP_API_KEY}")

# Parse only first svc-account from the list and take the id field.
SVC_ACCOUNT_ID=$(echo $ALL_ACCOUNTS | jq -r "[.[] | select(.name == \"$VCP_CLUSTER_NAME\")]" | jq -r "sort_by(.updatedOn) | reverse | .[0].id")

# Output JSON: {"uuid": $SVC_ACCOUNT_ID}
jq -c -n --arg uuid "$SVC_ACCOUNT_ID" '{"uuid": $uuid}'
