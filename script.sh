REGISTER="http://127.0.0.1:8500/v1/agent/service/register"

curl \
  --request PUT \
  ${REGISTER} \
  --data "{
    \"name\": \"node-exporter_node-exporter-01_1\",
    \"port\":9100,
    \"tags\":[\"node-exporter\", \"prometheus\"],
    \"address\": \"node-exporter_node-exporter-01_1\"
}"