# prometheus-auto-discovery
Prometheus - Auto discover nodes using consul.

A configration solution for Docker hosts and containers with [Prometheus](https://prometheus.io/), [Consul](http://consul.io/) and 
[NodeExporter](https://github.com/prometheus/node_exporter).

## Install
Clone this repository on your host, cd into prometheus-auto-discovery directory and ./bootstrap :

```bash
git clone https://github.com/maddygoround/prometheus-auto-discovery
cd prometheus-auto-discovery
./bootstrap.sh
```

Prerequisites:
* Docker Compose >= 1.29

Containers:

* Prometheus (metrics database) `http://<host-ip>:9090`
* NodeExporter (host metrics collector)
* Consul-server (containers metrics collector) `http://<host-ip>:8500`

Once promethes and consul-server containers are up, you can direct to cd nodes and start the node containers which contains ndoe_expoter and consul agent.
```
cd nodes
docker-compose up 
```

Consul agent will connect to the consul server.
promethes will read the list of nodes from the consul server and pull the metrics from each one of the nodes.

In case you want to deploy multiple nodes

```
cd nodes
docker-compose up -scale node_expoter=3
```
