#!/bin/sh

echo "Starting webhook pull at ${WEBHOOK_URL}"

url=${WEBHOOK_URL}
auth_token="${API_USER}: ${API_PASSWORD}"
content_type="Content-Type: application/json"
msg=$1
data="{\"to\": \"${API_DEST}\", \"subject\": \"${API_SUBJ}\", \"body\": \"$msg\"}"

curl -X POST -H "${auth_token}" -H "${content_type}" -d "${data}" ${url}

echo "Ending webhook pull"
