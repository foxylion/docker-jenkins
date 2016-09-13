
SHELL:=/bin/bash

up:
	cd docker/master && docker build -t my-jenkins .
	cd docker/slave && docker build -t my-jenkins-slave .
	docker run -d --restart=always --name jenkins -p 80:8080 -p 50000:50000 \
						 -v /vagrant/jenkins_home:/var/jenkins_home \
						 my-jenkins

clean:
	docker rm -f jenkins
