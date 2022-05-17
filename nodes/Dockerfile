FROM hashicorp/consul:1.10.0
RUN wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
RUN tar -xzf node_exporter-1.3.1.linux-amd64.tar.gz
RUN mv node_exporter-1.3.1.linux-amd64 node_exporter
RUN chmod +x ./node_exporter/node_exporter
RUN mkdir /etc/consul.d
ARG CONSUL_IP=latest
ENV CONSULIP=$CONSUL_IP
COPY ./consul.hcl /etc/consul.d
COPY ./service.json /etc/consul.d
COPY ./script.sh ./
RUN chmod +x ./script.sh
CMD ["sh","./script.sh"]