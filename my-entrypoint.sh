#!/bin/bash

if [[ -f ./FIRST_RUN ]]; then
    rm -f FIRST_RUN
    
    echo "Restoring database dump $DBDUMP"
    wget -q -O /backup.tar.gz \
        https://github.com/tutolmin/dbdump/raw/$DBDUMP/backup.tar.gz
    tar -zxv -C /data -f /backup.tar.gz --strip 1
    chown -R neo4j:neo4j /data
fi

/docker-entrypoint.sh neo4j
