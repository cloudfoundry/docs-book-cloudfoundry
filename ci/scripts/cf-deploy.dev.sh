#!/usr/bin/env bash

set -x -u

# Your ENV variables (Should be set externally, e.g. export CF_USERNAME="myUsername123")
# CF_API=
# CF_SHARED_DOMAIN=
# CF_USERNAME=
# CF_PASSWORD=
# CF_ORG=
# CF_SPACE=

max_health_checks=20
expected_response="200"
temp_suffix="-temp"

# Read from manifest.yml
app_name=$(grep " name:" manifest.yml | sed 's/.*://;s/ //g')
domain=$(grep " domain: " manifest.yml | sed 's/.*://;s/ //g')
hostname=$(grep " host: " manifest.yml | sed 's/.*://;s/ //g')

# Set default values
: "${domain:="${CF_SHARED_DOMAIN}"}"
: "${hostname:="${app_name}"}"

# Set up temporary app
temp_app_name="${app_name}${temp_suffix}"
temp_domain="${CF_SHARED_DOMAIN}"
temp_hostname="${app_name}${temp_suffix}"

# CF Login
cf api "${CF_API}"
cf login "${CF_USERNAME}" "${CF_PASSWORD}"
cf target -o "${CF_ORG}" -s "${CF_SPACE}"

# Push Green
cf push "${temp_app_name}" --no-route

# Map temporary route to Green
cf map-route "${temp_app_name}" "${temp_domain}" -n "${temp_hostname}"

# Wait for Green to be ready to serve
iterations=0
while [[ "${iterations}" -lt "${max_health_checks}" ]]
do
  response=$(curl -sIL -w "%{http_code}" -o /dev/null "${temp_hostname}.${temp_domain}")
  if [[ "${response}" == "${expected_response}" ]]; then
    printf "\n%s" "Got expected ${response} response"
    break
  else
    iterations=$(( iterations + 1 ))
    sleep 3 && printf "\n%s" "Waiting for ${expected_response} response... Got ${response} (${iterations}/${max_health_checks})"
  fi
done

if [[ "${iterations}" == "${max_health_checks}" ]]; then
  printf "\n%s\n\n" "Couldn't get ${expected_response} response. Reverting..."

  # Delete temporary route
  cf delete-route "${temp_domain}" -n "${temp_hostname}" -f

  # Stop temporary app
  cf stop "${temp_app_name}"

  exit 1
fi

# Load balance route between Blue and Green
cf map-route "${temp_app_name}" "${domain}" -n "${hostname}"

# Remove Blue from load balancing
cf unmap-route "${app_name}" "${domain}" -n "${hostname}"

# Delete temporary route
cf delete-route -f "${temp_domain}" -n "${temp_hostname}"

# Delete old app
cf delete -f -r "${app_name}"

# Rename Green to old app name
cf rename "${temp_app_name}" "${app_name}"#!/usr/bin/env bash
