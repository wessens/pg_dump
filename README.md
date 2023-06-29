# pg_dump
This repository contains a set of scripts that perform scheduled backups of a Postgres database. The scripts should be containerized in a Docker image.

The .env file contains the environment variables that control the behaviour of the script. However, the file itself is not used!
- PGDATABASE - the name of the database to dump.
- PGHOST - the host of the database
- PGUSER - the database user
- PGPASSWORD - the database password
- KEEP - the minimum number of old dumps to keep
- MAX_AGE- the minimum age of dumps to keep in seconds
- CRON_TIME - crontab formatted value to run the script. Not implemented yet
- WEBHOOK_URL - if export fails, you can pull a webhook using curl
- API_USER - the webhook user. Header auth is used
- API_PASSWORD - the webhook password. Header auth is used
- API_DEST - i have the email address to which alerts are sent here
- API_SUBJ - the email subject
