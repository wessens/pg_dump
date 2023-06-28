FROM alpine:3.16.2

RUN apk add --no-cache postgresql-client

COPY .env pg_dump.sh clean.sh /root/

RUN chmod 755 /root/pg_dump.sh

RUN chmod 755 /root/clean.sh



WORKDIR /root

ENTRYPOINT ["sh", "pg_dump.sh"]
