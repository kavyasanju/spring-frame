#!/usr/bin/env bash
eval $(minishift oc-env)
eval $(minishift docker-env)

docker login -u developer -p $(oc whoami -t) $(minishift openshift registry)
mvn clean install -DskipTests
docker build -t $(minishift openshift registry)/myproject/petclinic:latest -f dockerfiles/Jboss .
docker push $(minishift openshift registry)/myproject/petclinic:latest
