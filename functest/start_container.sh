INSTALLER_TYPE='fuel'
INSTALLER_IP='10.20.0.2'
DEPLOY_SCENARIO='os-odl_l2-sfc-noha'
CI_DEBUG=true
BUILD_TAG='fuel-daily'
envs="-e INSTALLER_TYPE=${INSTALLER_TYPE} -e INSTALLER_IP=${INSTALLER_IP} -e DEPLOY_SCENARIO=${DEPLOY_SCENARIO} -e CI_DEBUG=${CI_DEBUG} -e BUILD_TAG=${BUILD_TAG}"
cmd="sudo docker run --privileged=true -id ${envs} opnfv/functest:latest /bin/bash"
echo "Functest: Running docker run command: ${cmd}"
${cmd}
sleep 1
container_id=$(docker ps | grep 'opnfv/functest:latest' | awk '{print $1}' | head -1)
echo "Container ID=${container_id}"
if [ -z ${container_id} ]; then
    echo "Cannot find opnfv/functest container ID ${container_id}. Please check if it is existing."
    docker ps -a
    exit 1
fi
echo "Starting the container: docker start ${container_id}"
docker exec -ti ${container_id} /bin/bash
