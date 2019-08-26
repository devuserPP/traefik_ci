#!/bin/bash
#!/usr/bin/env bash
#vars
my_network=traefik_webgateway
traefik_compose_file=./traefik/docker-compose.yml
app_compose_file=./app/docker-compose.yml
postgres_volume=pgdata
param=$1

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

