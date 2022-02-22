FROM alpine:latest

RUN apk --no-cache add postgresql-client
RUN apk add --no-cache bash

COPY linksrus/linkgraph/store/postgres/migrations /migrations
COPY postgres-schema/bootstrap-db.sh .

ENV DB_NAME linkgraph
ENV PGPASSWORD Passw0rd
ENV PGUSER postgres
ENV DB_HOST postgres-postgresql-hl

ENTRYPOINT ["bash", "./bootstrap-db.sh"]
