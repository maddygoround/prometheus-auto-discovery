# prometheus-auto-discovery
Prometheus - Auto discover nodes using consul.

A configration solution for Docker hosts and containers with [Prometheus](https://prometheus.io/), [Consul](http://consul.io/) and 
[NodeExporter](https://github.com/prometheus/node_exporter).

## Installation
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
docker-compose up --scale node-exporter=3
```

## How does it works
The ```./bootstrap.sh``` deploys promethes and consul server agent.
prometheus takes the confirgration from promethes.yml file.
prometheus.yml is configured to read all the host machine from consul-server's endpoint based on the tag of the host registerd with consul

### prometheus.yml
```
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']

  - job_name: 'consul'
    consul_sd_configs:
      - server: 'consul:8500'
    relabel_configs:
      - source_labels: [__meta_consul_tags]
        regex: .*,prometheus,.*
        action: keep
      - source_labels: [__meta_consul_service]
        target_label: job
```

The ```docker-compose``` within the ```./nodes``` folder deploys the a container which contains node expoter and consul client agent.

consul clinet agent register themself with consul-server. To make this happen consul-server and consul-client container (which also contains node expoter) needs to share the same docker network.

Prometheus, consul-server and node expoter all share the same doccker network called ```"promnet"```


## Authors

- [@maddygoround](https://www.github.com/maddygoround)


## License
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)