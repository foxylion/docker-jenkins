
SHELL:=/bin/bash

up:
	cd docker/master && docker build -t my-jenkins .
	docker run -d --restart=always --name jenkins -p 80:8080 \
						 -v /var/run/docker.sock:/var/run/docker.sock \
						 -v /vagrant/jenkins_home:/var/jenkins_home \
						 my-jenkins

clean:
	docker rm -f jenkins
