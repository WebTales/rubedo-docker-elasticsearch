# Rubedo dockerfile
FROM centos:centos7
RUN yum -y update; yum -y clean all
# Install Supervisor and required packages
RUN yum install -y epel-release; yum -y clean all && \
    yum install -y java-1.7.0-openjdk.x86_64 tar wget supervisor; yum -y clean all
RUN mkdir -p /var/run/elasticsearch /var/log/supervisor /var/log/elasticsearch /usr/share/elasticsearch
COPY supervisord.conf /etc/supervisord.conf
#Install Mongo
RUN wget -O elasticsearch.tar.gz https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.5.2.tar.gz \
    && tar -zxvf elasticsearch.tar.gz -C /usr/share/elasticsearch --strip-components=1 \
    && rm -f elasticsearch.tar.gz
RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.5.0 \
    && /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-mapper-attachments/2.5.0
# Expose port
EXPOSE 9200 9300
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /*.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
