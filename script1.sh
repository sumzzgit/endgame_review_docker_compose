#!/bin/bash
echo "$TASK_DEFINITION" | jq --arg IMAGE "${BACKEND_REPO_URI}:latest" --arg DB_USER "${DB_USER}" --arg DB_PASS "${DB_PASS}" --arg DB_HOST "${DB_HOST}" --arg DB "${DB}" '.taskDefinition | .containerDefinitions[0].image = $IMAGE | .containerDefinitions[0].environment |= (. + [{"name": $ENV_VAR_NAME, "value": $ENV_VAR_VALUE}]) | del(.taskDefinitionArn, .revision, .status, .requiresAttributes, .compatibilities, .registeredAt, .registeredBy)'


---
NEW_TASK_DEFINITION=$(echo "$TASK_DEFINITION" | jq --arg IMAGE "nginx" --arg ENV_VAR_NAME "BACKEND_URL" --arg ENV_VAR_VALUE "http://backend.endgame.com " --arg ENV_VAR_NAME "BACKEND_URI" --arg ENV_VAR_VALUE "http://google.com" '.taskDefinition | .containerDefinitions[0].image = $IMAGE | .containerDefinitions[0].environment |= (. + [{"name": $ENV_VAR_NAME, "value": $ENV_VAR_VALUE}]) | del(.taskDefinitionArn, .revision, .status, .requiresAttributes, .compatibilities, .registeredAt, .registeredBy)')

refernce -> https://stackoverflow.com/questions/70633807/how-to-create-aws-task-definition-json-from-existing-task-definition

reference -> https://chat.openai.com/share/f41b9bea-827e-461c-b738-3fdf8c5ce773