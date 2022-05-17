#!/usr/bin/env bash
docker-compose up -d
consul_address=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' consul)
rm ./config/.env && touch ./config/.env
echo CONSUL_IP=$consul_address >> ./config/.env