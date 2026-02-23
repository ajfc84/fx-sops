#!/bin/sh


. "${CI_PROJECT_DIR}/buildSh/docker.sh"


echo "creating secrets volume..."
docker volume create secrets

docker_exec "${CI_PROJECT_NAME}" "${REGISTRY_IMAGE}" "${LATEST_VERSION}" \
    "-v secrets:/app/secrets" \
    "-v /home/b01t/.ssh:/root/.ssh:ro"