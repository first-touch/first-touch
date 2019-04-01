#!/bin/bash
set -xe

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $DIR
mkdir -p ../db/pg_data

docker volume create --name ft-pgdata

source $DIR/../.env
docker run --rm --name firsttouch-db \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    --publish 5432:5432 \
    -v "$PWD/my-postgres.conf":/etc/postgresql/postgresql.conf \
    -v ft-pgdata:/var/lib/postgresql/data  postgres
