#!/bin/bash

set -x
set -e

# shellcheck disable=SC1091
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# shellcheck disable=SC1091
. "${SCRIPTPATH}"/../../common/helpers.sh


INPUT_REGISTRY=docker.io
INPUT_ACCOUNT=bitnami
REPOSITORY=nginx

if [ "$#" -ne 1 ]; then
    PUBLISH_IMAGE="no"
else
    PUBLISH_IMAGE=$1
fi

cleanup_certs()
{
    rm -rf "${SCRIPTPATH}"/certs
    mkdir -p "${SCRIPTPATH}"/certs
}

create_certs()
{
    cleanup_certs

    openssl req -newkey rsa:4096 \
                -x509 \
                -sha256 \
                -days 3650 \
                -nodes \
                -out "${SCRIPTPATH}"/certs/server.crt \
                -keyout "${SCRIPTPATH}"/certs/server.key \
                -subj "/C=SI/ST=Ljubljana/L=Ljubljana/O=Security/OU=IT Department/CN=www.example.com"
}

test()
{
    local IMAGE_REPOSITORY=$1
    local TAG=$2
    local NAMESPACE=$3
    local HELM_RELEASE="$REPOSITORY"-release
    
    echo "Testing $REPOSITORY"

    # upgrade helm
    helm repo update

    # Install helm
    helm install "${HELM_RELEASE}" "${INPUT_ACCOUNT}"/"${REPOSITORY}" \
        --namespace "${NAMESPACE}" \
        --set image.tag="${TAG}" \
        --set image.repository="${IMAGE_REPOSITORY}" \
        --set ingress.hostname="${NAMESPACE}" \
        -f "${SCRIPTPATH}"/overrides.yml

    # waiting for pod to be ready
    echo "waiting for pod to be ready"
    kubectl wait deployments "${HELM_RELEASE}" -n "${NAMESPACE}" --for=condition=Available=True --timeout=10m

    # get pod name
    POD_NAME=$(kubectl -n "${NAMESPACE}" get pods -l app.kubernetes.io/name="$REPOSITORY" -o jsonpath="{.items[0].metadata.name}")

    # fetch service url and curl to url
    URL=$(minikube service "${HELM_RELEASE}" -n "${NAMESPACE}" --url)

    # curl to http url
    curl "${URL}"

    # fetch minikube ip
    MINIKUBE_IP=$(minikube ip)

    # curl to https url
    curl http://"${MINIKUBE_IP}" -k

    # copy common_commands.sh into container
    kubectl -n "${NAMESPACE}" cp "${SCRIPTPATH}"/../../common/tests/common_commands.sh "${POD_NAME}":/tmp/common_commands.sh

    # run command on cluster
    kubectl -n "${NAMESPACE}" exec -i "${POD_NAME}" -- /bin/bash -c "/tmp/common_commands.sh"

    # bring down helm install
    helm delete "${HELM_RELEASE}" --namespace "${NAMESPACE}"

    # delete the PVC associated
    kubectl -n "${NAMESPACE}" delete pvc --all

    # create ssl certs
    create_certs

    # update image in docker-compose yml
    sed "s#@IMAGE#${IMAGE_REPOSITORY}:${TAG}#g" "${SCRIPTPATH}"/docker-compose.yml.base > "${SCRIPTPATH}"/docker-compose.yml

    # install docker container
    docker-compose -f "${SCRIPTPATH}"/docker-compose.yml -p "${NAMESPACE}" up -d

    # sleep for 30 sec
    sleep 30

    # exec into container and run coverage script
    docker exec -i "${NAMESPACE}"_nginx_1 bash -c /opt/bitnami/scripts/coverage_script.sh

    # find non-tls and tls port
    NON_TLS_PORT=$(docker inspect "${NAMESPACE}"_nginx_1 | jq -r ".[].NetworkSettings.Ports.\"8080/tcp\"[0].HostPort")
    TLS_PORT=$(docker inspect "${NAMESPACE}"_nginx_1 | jq -r ".[].NetworkSettings.Ports.\"8443/tcp\"[0].HostPort")
    
    # run curl in loop for different endpoints
    for i in {1..20};
    do 
        echo "$i"
        curl http://localhost:"${NON_TLS_PORT}"/a
        curl http://localhost:"${NON_TLS_PORT}"/b
        curl https://localhost:"${TLS_PORT}"/a -k
        curl https://localhost:"${TLS_PORT}"/b -k
    done

    # logs for tracking
    docker-compose -f "${SCRIPTPATH}"/docker-compose.yml -p "${NAMESPACE}" logs

    # kill docker-compose setup container
    docker-compose -f "${SCRIPTPATH}"/docker-compose.yml -p "${NAMESPACE}" down

    # clean up docker file
    rm -rf "${SCRIPTPATH}"/docker-compose.yml

    # clean up certs
    cleanup_certs
}

declare -a BASE_TAG_ARRAY=("1.22.0-debian-10-r" "1.21.6-debian-10-r")

build_images "${INPUT_REGISTRY}" "${INPUT_ACCOUNT}" "${REPOSITORY}" test "${PUBLISH_IMAGE}" "${BASE_TAG_ARRAY[@]}"
