#!/usr/bin/env bash
docker-compose up -d
consul_address=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' consul)
rm ./nodes/.env && touch ./nodes/.env
echo CONSUL_IP=$consul_address >> ./nodes/.env