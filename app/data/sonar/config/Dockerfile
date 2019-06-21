FROM sonarqube:7.7-community
USER root
ADD wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod 777 /wait-for-postgres.sh
RUN chmod +x /wait-for-postgres.sh
