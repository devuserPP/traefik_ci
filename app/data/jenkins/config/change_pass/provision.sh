#!/bin/bash

# A simple example script that publishes a number of scripts to the Nexus Repository Manager
# and executes them.

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

username=admin
password=admin123

cd $(dirname $0)

# add the context if you are not using the root context
host=http://docker-nexus:8081/nexus




# add a script to the repository manager and run it
function addAndRunScript {
  name=$1
  file=$2
  groovy -Dgroovy.grape.report.downloads=true -Dgrape.config=grapeConfig.xml addUpdateScript.groovy -u "$username" -p "$password" -n "$name" -f "$file" -h "$host"
  printf "\nPublished $file as $name\n\n"
  curl -v -X POST -u $username:$password --header "Content-Type: text/plain" "$host/service/rest/v1/script/$name/run"
  printf "\nSuccessfully executed $name script\n\n\n"
}



# I want change the password only once

if [ ! -f /tmp/sonar.setting ]; then echo "Runing the Script for first time"

  printf "Provisioning Integration API Scripts Starting \n\n"
  printf "Publishing and executing on $host\n"

  addAndRunScript security security.groovy

  printf "\nProvisioning Scripts Completed\n\n"
  touch  /tmp/sonar.setting

else
  echo "File found! </tmp/sonar.setting> Script was already executed"
fi