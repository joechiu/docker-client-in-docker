FROM openshift/jenkins-2-centos7

USER root
RUN yum update -y
RUN yum install -y sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN yum install -y docker-client
RUN [ -d /home/jenkins ] || mkdir /home/jenkins
RUN echo "docker='sudo docker'" > /home/jenkins/.bashrc

USER jenkins

