#!/bin/bash
#vars
my_network=traefik_webgateway
traefik_compose_file=./traefik/docker-compose.yml
app_compose_file=./app/docker-compose.yml
postgres_volume=pgdata
param=$1
jenkins_home=./app/data/jenkins/jenkins_home
 
# [ "$d" == "" ] && { echo "Usage: $0 directory"; exit 1; }
# [ -d "${d}" ] &&  echo "Directory $d found." || echo "Directory $d not found."


#problem with maping jenkins volume
#inside container is used default user jenkins UID:GUI 1000:1000
#on the host must has this user permission for jenkins home

#create folder
#$mkdir ./app/data/jenkins/jenkins_home
#$cd ./app/data/jenkins/jenkins_home
#$pwd
#$chown -R 1000:1000 /c/temp/smazat_po_testu/dd/traefik_ci/app/data/jenkins/jenkins_home
#$chmod 777 /c/temp/smazat_po_testu/dd/traefik_ci/app/data/jenkins/jenkins_home
#$rm -r jenkins_home


if [ -d ${jenkins_home} ]; then
    echo ${jenkins_home} "Directory exists. Nothing to do" 
else
    echo "Settiong directory for jenkins_home."
    mkdir ${jenkins_home}
    cd ${jenkins_home}
    chown -R 1000:1000 ${PWD}
    chmod 777 ${PWD}
    echo ${PWD}
    cd -
    echo ${PWD}

fi


HOST_UID_GID=$(echo $(id -u):$(id -g))
export HOST_UID_GID
echo ${HOST_UID_GID}



echo param $1
#if docker network "webgateway" does not exists will be created
docker network inspect ${my_network} >/dev/null || docker network create --driver bridge ${my_network}

#if docker volume "pgdata" does not exists will be created
docker volume inspect ${postgres_volume} >/dev/null || docker volume create --name=${postgres_volume}



if [ "$param" == "rebuild" ]; then  
    echo "Rebuilding Docker images"
    docker-compose --file ${traefik_compose_file} up -d --force-recreate --$1 
    docker-compose --file ${app_compose_file} up -d --force-recreate --$1
    else
    echo "Without rebulding Docker images if already exists"
    docker-compose --file ${traefik_compose_file} up -d --force-recreate
    docker-compose --file ${app_compose_file} up -d --force-recreate
    fi

