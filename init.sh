#!/bin/bash
set -e

until pg_isready -h db-postgres -p 5432; do
  >&2 echo "Waiting for Postgres..."
  sleep 2
done

psql -v ON_ERROR_STOP=1 --username "postgres" --dbname "rawg" <<-EOSQL
	CREATE DATABASE metabase;
	GRANT ALL PRIVILEGES ON DATABASE metabase TO postgres;
EOSQL

sleep 20

curl -X POST http://magic:6789/api/pipeline_schedules/5/pipeline_runs/4c1c20cce05b45fcaab6b9034a2aaa70