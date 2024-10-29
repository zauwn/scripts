#!/bin/bash

usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }

# If no args show usage
[ $# -eq 0 ] && usage

# Parse options
while getopts "d:r:l:c:u:s:o:hi" arg; do
  case $arg in
    d) # keycloak url with http schema (http(s)://)
      URL="${OPTARG}"
      ;;
    i) # Request insecure SSL
      INSECURE="--insecure"
      ;;
    r) # Keycloak realm 
      REALM="${OPTARG}"
      ;;
    l) # Keycloak login option: "client_credentials" (service account) || "password" (user auth)
      LOGIN_OPTION="${OPTARG}"
      ;;
    c) # Keycloak client id to use for auth 
      CLIENT_ID="${OPTARG}"
      ;;
    u) # Keycloak username if using password (leave empty to prompt)
      USERNAME="${OPTARG}"
      ;;
    s) # Keycloak client secret or user password (leave empty to prompt)
      PASSWORD="${OPTARG}"
      ;;
    o) # What to do after result: "jwt" (print jwt auth token decoded) || "auth" (print auth token) 
      OPTION="${OPTARG}"
      ;;
    h | *) # Display help.
      usage
      exit 0
      ;;
  esac
done

# Check for required options
if [[ -z $URL || -z $REALM || -z $CLIENT_ID || -z $LOGIN_OPTION || -z $OPTION ]]; then 
  usage
  exit 1
fi

# Check SSL insecure flag
[[ -z ${INSECURE+x} ]] && INSECURE=""

# Set keycloak URL
KEYCLOAK_URL="$URL/auth/realms/$REALM/protocol/openid-connect/token"

case $LOGIN_OPTION in
  client_credentials)
    if [[ -z ${PASSWORD} ]]; then
      echo -n "Password:"
      read -s PASSWORD
    fi
    AUTH_TOKEN=$(curl -s -X POST "$KEYCLOAK_URL" "$INSECURE" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -d "client_secret=$PASSWORD" \
      -d "grant_type=$LOGIN_OPTION" \
      -d "client_id=$CLIENT_ID" | jq -r '.access_token')
    ;;
  password)
    if [[ -z ${USERNAME} ]]; then
      echo -n "Username:"
      read USERNAME
    fi
    if [[ -z ${PASSWORD} ]]; then
      echo -n "Password:"
      read -s PASSWORD
    fi
    AUTH_TOKEN=$(curl -s -X POST "$KEYCLOAK_URL" "$INSECURE" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -d "username=$USERNAME" \
      -d "password=$PASSWORD" \
      -d "grant_type=$LOGIN_OPTION" \
      -d "client_id=$CLIENT_ID" | jq -r '.access_token')
    ;;
  *)
    usage
    exit 2
    ;;
esac

# JWT decode helpers
_decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}
# $1 => JWT to decode
# $2 => either 1 for header or 2 for body (default is 2)
decode_jwt() { _decode_base64_url $(echo -n $1 | cut -d "." -f ${2:-2}) | jq .; }


case $OPTION in
  jwt)
    echo "header:"
    decode_jwt $AUTH_TOKEN 1
    echo "payload:"
    decode_jwt $AUTH_TOKEN 2
  ;;
  auth)
    echo $AUTH_TOKEN
  ;;
  *)
    echo $AUTH_TOKEN
  ;;
esac
