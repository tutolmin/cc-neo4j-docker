FROM neo4j:3.5.17

WORKDIR /

COPY my-entrypoint.sh /my-entrypoint.sh
RUN chmod +x /my-entrypoint.sh

# Check https://github.com/neo4j-contrib/neo4j-apoc-procedures#version-compatibility-matrix
ENV APOC_EXT_VERSION=3.5.0.11
#ENV APOC_EXT_SHA1=8e93f820534f46d83782e1cfcc50626d3dbb3de2

RUN mkdir /plugins
RUN wget -q -O /plugins/apoc-${APOC_EXT_VERSION}-all.jar \
	https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${APOC_EXT_VERSION}/apoc-${APOC_EXT_VERSION}-all.jar
#     && echo "${APOC_EXT_SHA1}  /plugins/apoc-${APOC_EXT_VERSION}-all.jar" | sha1sum --strict --quiet --status --check - 

RUN touch ./FIRST_RUN && \
    chmod a+w ./FIRST_RUN

ENV NEO4J_AUTH=neo4j/chessneo4j \
    NEO4J_dbms_security_procedures_unrestricted=apoc.\\\* \
    NEO4J_apoc_uuid_enabled=true \
    NEO4J_dbms_memory_pagecache_size=1G \
    NEO4J_dbms_tx__log_rotation_retention__policy=false \
    NEO4J_dbms_directories_data=/data

ENTRYPOINT ["/sbin/tini", "-g", "--", "/my-entrypoint.sh"]

CMD ["neo4j"]
