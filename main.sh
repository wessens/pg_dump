#!/bin/sh

echo "Start"

echo "Starting export procedure"
sh pg_dump.sh
echo "Ending export procedure"

echo "Starting cleanup procedure"
sh clean.sh /app/share/backup/
sh clean.sh /app/share/log/
echo "Ending cleanup procedure"

echo "End"
