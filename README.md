# jenkins-vagrant-docker
Jenkins inside Docker, running in Vagrant VM. Only Docker installed on Host, provisioning of slaves using Docker.

## Useful links

- First step with Jenkins pipelines. Includes steps, stages, stash, docker
 - https://dzone.com/refcardz/continuous-delivery-with-jenkins-workflow

## Setup the Cloud provider

- OpenGo to Settings -> System
- Go to section Cloud
- Press: Add "Yet another Cloud"
- Enter data
 - Cloud Name: master
 - Docker URL: tcp://10.111.0.10:2376
- Press: Add Docker Template
- Enter data
 - Docker Image Name: my-jenkins-slave
 - Labels: docker
- Add: Environment Variable under "Node Properties"...
 - Name: DOCKER_HOST
 - Value: tcp://10.111.0.10:2376

## Sample Jenkinsfile

Setup a new Jenkins job (Pipeline):

```groovy
node('docker') {
    sh 'printenv'
    docker.image('ubuntu:14.04').inside {
        sh 'lsb_release -a'
    }
}
```
