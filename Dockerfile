FROM alpine:3.16.2

RUN apk add --no-cache postgresql-client curl

COPY .env pull_webhook.sh pg_dump.sh clean.sh main.sh /root/

RUN chmod 755 /root/pull_webhook.sh

RUN chmod 755 /root/pg_dump.sh

RUN chmod 755 /root/clean.sh

RUN chmod 755 /root/main.sh

RUN crontab -l > mycron && \
	echo "${CRON_TIME} /root/main.sh" >> mycron && \
	crontab mycron && \
	rm mycron

WORKDIR /root

CMD ["crond", "-l", "2", "-d", "8", "-f"]
