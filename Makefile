
SHELL:=/bin/bash

build: build-master build-slave

build-master:
	cd docker-images/master && docker build -t foxylion/jenkins .

build-slave:
	cd docker-images/slave && docker build -t foxylion/jenkins-slave .

run-master:
	docker run -d --restart=always --name jenkins \
	           -p 80:8080 -p 50000:50000 \
	           -v /vagrant/jenkins_home:/var/jenkins_home \
	           foxylion/jenkins

run-slave:
	docker run -d --restart=always --name jenkins-slave \
	           -v /home/jenkins:/home/jenkins \
	           -v /var/run/docker.sock:/var/run/docker.sock \
	           -e JENKINS_URL=http://10.111.0.10 \
	           foxylion/jenkins-slave

vagrant: build run-master run-slave
