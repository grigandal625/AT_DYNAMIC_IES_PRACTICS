#!/bin/bash
set -e

apply_migration() {
    local repo_url="$1"
    local repo_dir="$2"
    local db_name="$3"

    export DB_NAME=$db_name
    export DB_HOST=at_postgres
    export DB_PORT=${AT_POSTGRES_DB_PORT}
    export DB_USER=${AT_POSTGRES_DB_USER}
    export DB_PASS=${AT_POSTGRES_DB_PASS}

    if [ -d "$repo_dir" ]; then
        cd "$repo_dir"
        git pull
    else
        git clone "$repo_url"
        cd "$repo_dir"
    fi

    pip install alembic psycopg2-binary git+$repo_url

    cd migrations
    set +a && bash upgrade_head.sh
    cd ..
}

apply_migration "https://github.com/leerycorsair/at_user_api.git" "at_user_api" ${AT_POSTGRES_DB_NAME_USER}
apply_migration "https://github.com/leerycorsair/at_simulation_api.git" "at_simulation_api" ${AT_POSTGRES_DB_NAME_SIMULATION}
