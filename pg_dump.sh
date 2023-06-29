#!/bin/sh

# The following environment variables must be set in order for this to work
# PGDATABASE 
# PGHOST 
# PGUSER
# PGPASSWORD

datestr=$(date "+%Y%m%dT%H%M%S")
fname_dump="${datestr}.pgdump"
fname_log="${fname}.log"
pg_dump -v -w -Fc -f /app/share/backup/$fname_dump --compress=4 --host="$PGHOST" --username="$PGUSER" --dbname="$PGDATABASE" 2> /app/share/log/$fname_log

code=$?
if [ $code -ne 0 ]; then
  echo 1>&2 "The backup failed (exit code $code), check for errors in $fname_log"
fi

exit
