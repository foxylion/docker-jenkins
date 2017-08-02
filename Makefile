
SHELL:=/bin/bash

build: build-master build-slave

build-master:
	cd docker-images/master && docker build -t foxylion/jenkins .

build-slave:
	cd docker-images/slave && docker build -t foxylion/jenkins-slave .

build-ssh-slave:
	cd docker-images/ssh-slave && docker build -t foxylion/jenkins-ssh-slave .
