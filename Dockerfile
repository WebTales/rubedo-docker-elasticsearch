# Rubedo dockerfile
FROM centos:centos7
RUN yum -y update; yum -y clean all

# Install required packages
RUN yum install -y epel-release; yum -y clean all && \
    yum install -y java-1.7.0-openjdk.x86_64 tar wget; yum -y clean all
RUN mkdir -p /var/run/elasticsearch /var/log/elasticsearch /usr/share/elasticsearch

WORKDIR /usr/share/elasticsearch

# Expose port
EXPOSE 9200 9300
ENV ES_VERSION elasticsearch-1.5.2
ENV PLUGINS **None**

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /*.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["./bin/elasticsearch"]
