FROM debezium/connect:2.6
USER root
RUN mkdir -p /kafka/connect/plugins && chown -R kafka:kafka /kafka
USER kafka
RUN curl -L -o /tmp/iceberg-kc.tar.gz https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-kafka-connect-runtime/1.5.2/iceberg-kafka-connect-runtime-1.5.2.tar.gz &&   mkdir -p /kafka/connect/plugins/iceberg &&   tar -xzf /tmp/iceberg-kc.tar.gz -C /kafka/connect/plugins/iceberg && rm -f /tmp/iceberg-kc.tar.gz
