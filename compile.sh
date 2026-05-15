#!/bin/sh

. "${CI_PROJECT_DIR}/buildSh/utils.sh"


cp_src "build" "src"

echo "copying secrets file from ${CI_ENVIRONMENT_NAME} env to ${CI_PROJECT_NAME} project..."

SOPS_SECRETS_FILE="${CI_PROJECT_DIR}/secrets.${CI_ENVIRONMENT_NAME}.yaml"
if [ ! -f "${SOPS_SECRETS_FILE}" ];
then
    SOPS_SECRETS_FILE="${CI_PROJECT_DIR}/secrets.yaml"
fi
cp "${SOPS_SECRETS_FILE}" "${SUB_PROJECT_DIR}/build/secrets.yml"

SOPS_CONFIG_FILE="${CI_PROJECT_DIR}/.sops.${CI_ENVIRONMENT_NAME}.yaml"
if [ ! -f "${SOPS_CONFIG_FILE}" ];
then
    SOPS_CONFIG_FILE="${CI_PROJECT_DIR}/.sops.yaml"
fi
cp "${SOPS_CONFIG_FILE}" "${SUB_PROJECT_DIR}/build/.sops.yaml"