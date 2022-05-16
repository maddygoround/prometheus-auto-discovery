#!/usr/bin/env bash
consul_address=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' consul)
sh ./node_exporter/node_exporter
consul agent --config-dir=/etc/consul.d/ --retry-join=$consul_address