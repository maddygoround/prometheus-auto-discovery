#!/usr/bin/env bash
nohup ./node_exporter/node_exporter &
consul agent -config-dir=/etc/consul.d/ -retry-join=$CONSULIP