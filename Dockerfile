FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.1

USER root
RUN yum install -y \
      epel-release
RUN yum install -y \
      jq
RUN yum install -y \
      net-tools

USER elasticsearch

RUN elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.5.1 \
	&& elasticsearch-plugin remove x-pack --purge

ENV BOOTSTRAP_MLOCKALL=false NODE_DATA=true NODE_MASTER=true

COPY pre-stop-hook.sh /pre-stop-hook.sh
COPY entrypoint.sh bin/entrypoint.sh

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

USER root
RUN chown elasticsearch:elasticsearch config/elasticsearch.yml
RUN chown -R elasticsearch:elasticsearch data/
CMD ["/bin/bash", "bin/entrypoint.sh"]
