#!/bin/bash
# Author: Sharad Chhetri
# Description: Update all Jenkins plugin
# Version 1.0

_JENKINS_URL=http://docker_jenkins:8080/jenkins
_JENKINS_USER=admin
_JENKINS_PASSWD=admin

#copy file to tmp
cd /
cp -n ./var/jenkins_home/war/WEB-INF/jenkins-cli.jar /tmp
cd /tmp
java -jar jenkins-cli.jar -s "$_JENKINS_URL" -auth "$_JENKINS_USER:$_JENKINS_PASSWD" -noKeyAuth list-plugins|  grep -e ')$' | awk '{ print $1 }'| while read _UPDATE_LIST;
do
echo "Starting to install plugin: "$_UPDATE_LIST;
java -jar jenkins-cli.jar -s "$_JENKINS_URL" -auth "$_JENKINS_USER:$_JENKINS_PASSWD" -noKeyAuth install-plugin "$_UPDATE_LIST";
sleep 10;
done

java -jar jenkins-cli.jar -s "$_JENKINS_URL" -auth "$_JENKINS_USER:$_JENKINS_PASSWD" -noKeyAuth safe-restart;