#!/bin/sh


. "${CI_PROJECT_DIR}/buildSh/utils.sh"

mk_build

cp_src "build" "src"

echo "copying secrets file from ${CI_ENVIRONMENT_NAME} env to ${CI_PROJECT_NAME} project..."
cp "${CI_PROJECT_DIR}/secrets.${CI_ENVIRONMENT_NAME}.yml" "${SUB_PROJECT_DIR}/build/secrets.yml"
#cp "${CI_PROJECT_DIR}/.sops.yaml" "${SUB_PROJECT_DIR}/build/"