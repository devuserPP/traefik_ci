FROM jenkinsci/blueocean:1.19.0

#Jenkins_Autoupdate/Supercronic
#*****************************

USER root
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.9/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=5ddf8ea26b56d4a7ff6faecdd8966610d5cb9d85

RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

ADD crontab /etc/crontab
COPY ./jenkins_update.sh /usr/local/bin/

#*****************************
#Jenkins_Install/sonar-scanner-cli
#*****************************


ENV VERSION=4.1.0.1829 \
    PATH=$PATH:/opt/sonar-scanner/bin

RUN wget -O /tmp/sonar.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$VERSION.zip && \
    unzip /tmp/sonar.zip -d /tmp && \
    mkdir -p /opt/sonar-scanner && \
    cp -R /tmp/sonar-scanner-$VERSION/* /opt/sonar-scanner/ && \
    rm -rf /tmp/sonar.zip

#*****************************
#Jenkins_Install/ToDO
#*****************************

copy ./sonar-scanner.properties /opt/sonar-scanner/conf/ 
#testing
#$sonar-scanner --version -X
#$sonar-scanner -X
#try rename docker-sonar to docker-sonar

#config
#https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/
# token na sonar
# 3f23dded147b7c0e7a62c38ec698e1621c5adf2f
# zdroj:
# https://funnelgarden.com/sonarqube-jenkins-docker/






COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]




#*****************************
#Nexus_Install/groovy
#*****************************
user root

ARG GROOVY_VERSION=2.5.8


ENV GROOVY_HOME=/opt/groovy-$GROOVY_VERSION/ \
    PATH=/opt/groovy-$GROOVY_VERSION/bin:$PATH


RUN wget -O /tmp/groovy-$GROOVY_VERSION.zip https://dl.bintray.com/groovy/maven/apache-groovy-binary-$GROOVY_VERSION.zip && \
unzip /tmp/groovy-$GROOVY_VERSION.zip && \
mv groovy-$GROOVY_VERSION /opt && \
rm -rf /tmp/groovy-$GROOVY_VERSION.zip

COPY change_pass /opt/change_pass
RUN ls /opt
ADD wait-for-it.sh /bin/wait-for-it.sh
RUN chmod 775 /bin/wait-for-it.sh && \
    chmod 775 /opt/change_pass/provision.sh
RUN echo "exec ./opt/change_pass/provision.sh" >> /usr/local/bin/jenkins.sh
# RUN echo "wait-for-it.sh docker-nexus:8081/nexus --timeout=20 -- ./opt/change_pass/provision.sh" >> /usr/local/bin/jenkins.sh



#$docker exec -it docker-jenkins bash
#$docker info

#can see that user jenkins does not have permission to run "docker info"
#$ls -all /var/run/docker.sock

#can see that only user=root and group=root have RW permission

# Add user jenkins inside group "root"
RUN adduser jenkins root

USER jenkins


#///////////////////////////////
#Jenkins_Autoupdate/Old
#*****************************
#COPY ./jenkins_update.sh /etc/periodic/15min/jenkins_update

# Alpine comes with built in cron schedules
# min   hour    day     month   weekday command
# */15    *       *       *       *       run-parts /etc/periodic/15min
# 0       *       *       *       *       run-parts /etc/periodic/hourly
# 0       2       *       *       *       run-parts /etc/periodic/daily
# 0       3       *       *       6       run-parts /etc/periodic/weekly
# 0       5       1       *       *       run-parts /etc/periodic/monthly
# Place script in appropriate folder


# USER root
# - Im using command in docker-compose.yml
# CMD ["crond", "-l", "2", "-L", "/var/jenkins_home/logs/cron.log"]
# bash-4.4# crond --help
# BusyBox v1.28.4 (2018-05-30 10:45:57 UTC) multi-call binary.
# Usage: crond -fbS -l N -d N -L LOGFILE -c DIR
#        -f      Foreground
#        -b      Background (default)
#        -S      Log to syslog (default)
#        -l N    Set log level. Most verbose 0, default 8
#        -d N    Set log level, log to stderr
#        -L FILE Log to FILE
#        -c DIR  Cron dir. Default:/var/spool/cron/crontabs