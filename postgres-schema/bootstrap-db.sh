#!/bin/bash
set -e

# Assemble migration steps
cat /migrations/*.up* >> /tmp/migrations-all.sql

# Try to apply the schema in a loop so we can wait until the postgres cluster is ready
# until cat /tmp/migrations-all.sql | ./cockroach sql --insecure --echo-sql --host $DB_HOST; do
until psql -h $DB_HOST -p 5432 -d $DB_NAME -U $PGUSER -f /tmp/migrations-all.sql -w; do
	sleep 5;
done
