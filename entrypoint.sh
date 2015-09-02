#!/bin/bash
set -e

NODE_ID=${HOSTNAME: -1}
CLUSTER_NAME=$(echo ${HOSTNAME} | cut -d '-' -f2)                                       
#Install elasticsearch
wget -O elasticsearch.tar.gz https://download.elasticsearch.org/elasticsearch/elasticsearch/"${ES_VERSION}".tar.gz && tar -zxvf elasticsearch.tar.gz -C /usr/share/elasticsearch --strip-components=1 && rm -f elasticsearch.tar.gz
if [ "${PLUGINS}" != "**None**" ]; then
		IFS=',' read -a array <<< "$PLUGINS"
		for element in "${array[@]}"
       		do
            	/usr/share/elasticsearch/bin/plugin install elasticsearch/"$element"
		done
fi
bin/plugin --install mobz/elasticsearch-head
sed -i -e "s/#cluster.name: elasticsearch/cluster.name: $CLUSTER_NAME/g" config/elasticsearch.yml
sed -i -e "s/#node.name: \"Franz Kafka\"/node.name: \"node_$NODE_ID\"/g" config/elasticsearch.yml

exec "$@"

