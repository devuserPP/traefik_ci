#source from https://github.com/SonarSource/docker-sonarqube/blob/master/7.8-community/Dockerfile
# sonar container can not start with root permission, so switch back to sonarqube
#I do not use this script in this case, becouse inside container (Dockerfile of sonarqube:7.8-community is running run.sh)
FROM sonarqube:7.8-community
USER root
ADD wait-for-it.sh /bin/wait-for-it.sh
RUN chmod 775 /bin/wait-for-it.sh
USER sonarqube
