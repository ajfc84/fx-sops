#!/bin/sh


. "${CI_PROJECT_DIR}/buildSh/docker.sh"
. "${CI_PROJECT_DIR}/buildSh/artifacts.sh"


ANSIBLE_CMD=$(cat <<EOF
ansible-playbook -i /config/inventories/my-inventory.yaml \
    -l ${CI_ENVIRONMENT_NAME} \
    -e base_dir=/config \
    -e ci_registry=${CI_REGISTRY} \
    -e ci_registry_user=${CI_REGISTRY_USER} \
    -e ci_registry_password=${CI_REGISTRY_PASSWORD} \
    -e registry_image=${REGISTRY_IMAGE} \
    -e image_version=${LATEST_VERSION} \
    -e project=${CI_PROJECT_NAME} \
    /config/playbooks/cloud-playbook.yaml
EOF
)

docker_exec "fx-config" "${CI_PROJECT_PATH}/fx-config" "${FX_CONFIG_RELEASE}" \
    "${ANSIBLE_CMD}" \
    "-v /home/b01t/.ssh:/root/.ssh:ro" \
    "--mount type=bind,source=${SUB_PROJECT_DIR}/project.yaml,target=/config/playbooks/vars.yaml" \
    "--mount type=bind,source=${CI_PROJECT_DIR}/inventory.yml,target=/config/inventories/my-inventory.yaml"
