#!/bin/bash

set -ex

export PGDATA="$RUNNER_TEMP/pgdata"

echo $RUNNER_OS

if [ "$RUNNER_OS" = "Windows" ]; then
    export PATH="$PGBIN:$PATH"
    export PQ_LIB_DIR='$PGROOT\\lib'
    export PGUSER="$USERNAME"
fi

if [ "$RUNNER_OS" = "macOS" ]; then
    export PGUSER="$USER"
fi

echo $PATH
echo $PGUSER

pg_ctl init
pg_ctl start
createuser --createdb prisma
createdb -O prisma tests
psql -c "ALTER USER prisma PASSWORD 'prisma';" tests

echo 'TEST_POSTGRES_URI="postgres://prisma:prisma@localhost:5432/tests"' >> $GITHUB_ENV
echo 'TEST_POSTGRES_URI_MIGRATE="postgres://prisma:prisma@localhost:5432/tests-migrate"' >> $GITHUB_ENV
echo 'TEST_POSTGRES_SHADOWDB_URI_MIGRATE="postgres://prisma:prisma@localhost:5432/tests-migrate-shadowdb"' >> $GITHUB_ENV
