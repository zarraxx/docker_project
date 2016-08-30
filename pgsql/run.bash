#!/bin/bash

docker volume rm pgsql
docker run --rm -ti -p 5432:5432 -e POSTGRES_PASSWORD=P@ssw0rd -v pgsql:/var/lib/postgresql/data pgsql $1
