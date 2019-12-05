FROM sonatype/nexus3:3.19.1



#*****************************
#Nexus/install_groovy
#*****************************
# install groovy for run groovy script that change default admin password for nexus
# trying to run this script after nexus is up, but stil does not work.
# this working $docker exec -it docker-nexus ./opt/nexus_change_pass/provision.sh
user root

ARG GROOVY_VERSION=2.5.8


ENV GROOVY_HOME=/opt/groovy-$GROOVY_VERSION/ \
    PATH=/opt/groovy-$GROOVY_VERSION/bin:$PATH

RUN yum install unzip wget -y && \
wget -O /tmp/groovy-$GROOVY_VERSION.zip https://dl.bintray.com/groovy/maven/apache-groovy-binary-$GROOVY_VERSION.zip && \
unzip /tmp/groovy-$GROOVY_VERSION.zip && \
mv groovy-$GROOVY_VERSION /opt && \
rm -rf /tmp/groovy-$GROOVY_VERSION.zip

COPY nexus_change_pass /opt/nexus_change_pass
RUN ls /opt
ADD wait-for-it.sh /bin/wait-for-it.sh
RUN chmod 775 /bin/wait-for-it.sh && \
    chmod 775 /opt/nexus_change_pass/provision.sh
RUN echo "echo 'hello word'" >> ${SONATYPE_DIR}/start-nexus-repository-manager.sh
RUN echo "exec ./opt/nexus_nexus_change_pass/provision.sh" >> ${SONATYPE_DIR}/start-nexus-repository-manager.sh
USER nexus



