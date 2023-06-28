#!/bin/sh

# The following environment variables must be set in order for this to work
# PGDATABASE 
# PGHOST 
# PGUSER
# PGPASSWORD

fname=$(date "+%Y%m%dT%H%M%S")
fname_log="${fname}.log"
pg_dump -v -w -Fc -f /app/share/backup/$fname --compress=4 --host="$PGHOST" --username="$PGUSER" --dbname="$PGDATABASE" 2> /app/share/log/$fname_log
exit
