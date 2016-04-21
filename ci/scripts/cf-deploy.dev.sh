#!/usr/bin/env bash

# Your ENV variables (Should be set externally, e.g. export CF_USERNAME="myUsername123")
# CF_API=
# CF_SHARED_DOMAIN=
# CF_USERNAME=
# CF_PASSWORD=
# CF_ORG=
# CF_SPACE=

MAX_HEALTH_CHECKS=10
EXPECTED_RESPONSE="200"
TEMP_SUFFIX="-dev-temp"

# Read from manifest.yml
APP_NAME=$(grep " name:" manifest.yml | sed 's/.*://;s/ //g')
DOMAIN=$(grep " domain: " manifest.yml | sed 's/.*://;s/ //g')
HOSTNAME=$(grep " host: " manifest.yml | sed 's/.*://;s/ //g')

# Set default values
: "${DOMAIN:="${CF_SHARED_DOMAIN}"}"
: "${HOSTNAME:="${APP_NAME}"}"

# Set up temporary app
TEMP_APP_NAME="${APP_NAME}${TEMP_SUFFIX}"
TEMP_DOMAIN="${CF_SHARED_DOMAIN}"
TEMP_HOSTNAME="${APP_NAME}${TEMP_SUFFIX}"

# CF Login and Auth
cf api "${CF_API}"
cf auth "${CF_USERNAME}" "${CF_PASSWORD}"
cf target -o "${CF_ORG}" -s "${CF_SPACE}"

# Push Green
cf push "${TEMP_APP_NAME}" --no-route

# Map temporary route to Green
cf map-route "${TEMP_APP_NAME}" "${TEMP_DOMAIN}" -n "${TEMP_HOSTNAME}"

# Wait for Green to be ready to serve
ITERATIONS=0
while [[ "${ITERATIONS}" -lt "${MAX_HEALTH_CHECKS}" ]]
do
  RESP=$(curl -sIL -w "%{http_code}" -o /dev/null "${TEMP_HOSTNAME}.${TEMP_DOMAIN}")
  if [[ "${RESP}" == "${EXPECTED_RESPONSE}" ]]; then
    break
  else
    ITERATIONS=$(( ITERATIONS + 1 ))
    sleep 3 && printf "\n%s" "Waiting for ${EXPECTED_RESPONSE} response (${ITERATIONS}/${MAX_HEALTH_CHECKS})"
  fi
done

if [[ "${ITERATIONS}" == "${MAX_HEALTH_CHECKS}" ]]; then
  printf "\n%s\n\n" "Couldn't get ${EXPECTED_RESPONSE} response. Reverting..."

  # Delete temporary route
  cf delete-route "${TEMP_DOMAIN}" -n "${TEMP_HOSTNAME}" -f

  # Delete temporary app
  cf delete -f -r "${TEMP_APP_NAME}"

  exit 1
fi

# Load balance route between Blue and Green
cf map-route "${TEMP_APP_NAME}" "${CF_SHARED_DOMAIN}" -n "${HOSTNAME}"

# Remove Blue from load balancing
cf unmap-route "${APP_NAME}" "${CF_SHARED_DOMAIN}" -n "${HOSTNAME}"

# Delete temporary route
cf delete-route -f "${TEMP_DOMAIN}" -n "${TEMP_HOSTNAME}"

# Delete old app
cf delete -f -r "${APP_NAME}"

# Rename Green to old app name
cf rename "${TEMP_APP_NAME}" "${APP_NAME}"
