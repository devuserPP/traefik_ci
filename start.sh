#!/bin/bash
#vars
my_network=traefik_webgateway
traefik_compose_file=./traefik/docker-compose.yml
app_compose_file=./app/docker-compose.yml
postgres_volume=pgdata
param=$1
jenkins_home=./app/data/jenkins/jenkins_home
#TZ=$(readlink /etc/localtime | sed 's#/var/db/timezone/zoneinfo/##') 



#problem with maping jenkins volume
#inside container is used default user jenkins UID:GUI 1000:1000
#on the host must have this user permission for jenkins home

#create folder
#$mkdir ./app/data/jenkins/jenkins_home
#$cd ./app/data/jenkins/jenkins_home
#$pwd
#$chown -R 1000:1000 /c/temp/smazat_po_testu/dd/traefik_ci/app/data/jenkins/jenkins_home
#$chmod 777 -R /c/temp/smazat_po_testu/dd/traefik_ci/app/data/jenkins/jenkins_home
#$rm -r jenkins_home
#on Docker desktop go to settings/ shared drivers/ unselect c select again. Meabe restart docker


if [ -d ${jenkins_home} ]; then
    echo ${jenkins_home} "Directory exists. Nothing to do" 
else
    echo "Setting directory for jenkins_home."
    mkdir ${jenkins_home}
    cd ${jenkins_home}
    chown -R 1000:1000 ${PWD}
    chmod 777 ${PWD}
    echo ${PWD}
    cd -
    echo ${PWD}

fi





echo param $1
#if docker network "webgateway" does not exists will be created
docker network inspect ${my_network} >/dev/null || docker network create --driver bridge ${my_network}

#if docker volume "pgdata" does not exists will be created
docker volume inspect ${postgres_volume} >/dev/null || docker volume create --name=${postgres_volume}



if [ "$param" == "rebuild" ]; then  
    echo "Rebuilding Docker images"
    docker-compose --file ${traefik_compose_file} up -d --force-recreate --build 
    docker-compose --file ${app_compose_file} up -d --force-recreate --build 
    else
    echo "Without rebulding Docker images if already exists"
    docker-compose --file ${traefik_compose_file} up -d --force-recreate
    docker-compose --file ${app_compose_file} up -d --force-recreate

fi

#check if docker client (docker info inside container "docker-jenkins") can connect to docker host
#UID:GID from container
# docker exec -it docker-jenkins id

#UID:GID from docker host
# HOST_UID_GID=$(echo $(id -u):$(id -g))
# export HOST_UID_GID
# echo ${HOST_UID_GID}

#change permission for connection docker client (from container "docker-jenkins") to docker host
#sudo chown 1000:1000 /var/run/docker.sock