#!/bin/sh

# The following environment variables must be set in order for this to work
# PGDATABASE
# PGHOST
# PGUSER
# PGPASSWORD

datestr=$(date "+%Y%m%dT%H%M%S")
fname_dump="${datestr}.pgdump"
fname_log="${fname_dump}.log"

pg_dump -v -w -Fc --compress=0 --blobs -f /app/share/backup/${fname_dump} --host="${PGHOST}" --username="${PGUSER}" --dbname="${PGDATABASE}" 2> /app/share/log/${fname_log}

code=$?
if [ ${code} -eq 0 ]; then
  success_msg="Backup completed successfully for host=${PGHOST}, database=${PGDATABASE}"
  echo ${success_msg}
  if [ -z "${WEBHOOK_URL}" ]; then
    echo "WEBHOOK_URL environment variable is not defined"
  else
    sh pull_webhook.sh "${success_msg}"
  fi
else
  error_msg="The backup failed (exit code ${code}), check for errors in ${fname_log} for host=${PGHOST}, database=${PGDATABASE}"
  echo 1>&2 ${error_msg}
  if [ -z "${WEBHOOK_URL}" ]; then
    echo "WEBHOOK_URL environment variable is not defined"
  else
    sh pull_webhook.sh "${error_msg}"
  fi
fi
