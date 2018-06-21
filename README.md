# Docker Client in Docker for Jenkins Container

## Synopsis
The primary purpose of running Docker clients in a Docker Jenkins container is to allow the Jenkins system to handle multiple container instances during the CI/CD testing with the development of Docker itself to make the tests to be more efficient, less risky.

You probably have read these articles, [blog post](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/) and [git dind](https://github.com/jpetazzo/dind/), and understand about the risks of running multiple Dockers in Docker. By this example, the docker in the Jenkins server acted as a client to the host to prevent from the potential issues as mentioned in the articles.

## Systems / Applications
* OS: Linux RHEL 7.5
* Ansible: 2.7.5
* Docker: 1.13.1
* Jenkins container: 2.121.1 (openshift/jenkins-2-centos7)
* Python: 2.7.5
* Platform: Google Cloud Platform

## Installation
1. git clone https://github.com/joehmchiu/docker-client-in-docker.git
2. cd docker-client-in-docker/
3. run ansible playbook by command:<br>
    $ ansible-playbook -vvv build-my-jenkins.yml
4. Ignore or troubleshoot the errors generated while cleaning the docker containers.
5. When infrastructure completed, prompt the following command to see if the docker process is up:<br>
    $ docker ps -l
<pre>
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                                                NAMES
5f66686982f2        myjenkins           "/usr/bin/dumb-ini..."   About an hour ago   Up About an hour    53/tcp, 8443/tcp, 0.0.0.0:50000->50000/tcp, 0.0.0.0:9191->8080/tcp   romantic_kare
</pre>
6. Update firewall to allow access going through port 9191.
7. Browse http://&lt;host ip&gt;:9191/ to see if the Jenkins server is online.
8. Please note this version of Jenkins container won't go to the installation process, it goes to an authentication page instead. Type 'foobar' as password to login. BTW, you can change the password in jenkins-container.yml before running ansible playbook.
9. You may run your dockerfile as docker client by Jenkins pipeline to see the docker status by using the following command. <br>
    $ docker stats
<pre>
CONTAINER           CPU %               MEM USAGE / LIMIT       MEM %               NET I/O             BLOCK I/O           PIDS
2b3e3603e067        0.54%               369.3 MiB / 2.288 GiB   15.76%              6.26 MB / 3.15 MB   97.2 MB / 86.5 MB   130
d9c471e9ff8e        3.13%               516 KiB / 2.288 GiB     0.02%               2.82 kB / 648 B     0 B / 0 B           6
8958a3b1d0dc        0.00%               524 KiB / 2.288 GiB     0.02%               2.56 kB / 578 B     0 B / 0 B           6
a64079f26469        0.20%               532 KiB / 2.288 GiB     0.02%               2.05 kB / 578 B     0 B / 0 B           6
61a520059e50        3.17%               528 KiB / 2.288 GiB     0.02%               1.46 kB / 508 B     0 B / 0 B           6
cf27a7c31488        0.00%               532 KiB / 2.288 GiB     0.02%               1.04 kB / 508 B     0 B / 0 B           6
</pre>

## Troubleshooting
As you seen the dockerfile is going to add user jenkins to be a sudoer. It's available to become root to troubleshoot if meet any jenkins setup issues in the container. For some reason the jenkins user id in the container was set as 999 instead of 1000 therefore you need to run as user 999 on the running container. eg. running bash session:

* docker exec -u 999 -it &lt;container ID&gt; bash

## License
A short snippet describing the license (MIT, Apache, etc.)

