#!/usr/bin/env bash

eval $(minishift oc-env)
oc login -u developer -p $(oc whoami -t)

APP_SVC_NAME=petclinic
DB_SV_NAME=$APP_SVC_NAME-mysql

# set projectname
oc project myproject

# create mySql service
MYSQL_PASSWORD=$(openssl rand -base64 12)
oc new-app -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=$MYSQL_PASSWORD -e MYSQL_DATABASE=petclinic --image-stream=myproject/mysql-55-centos7 --name $DB_SV_NAME

# create configMap for petclinic
oc create configmap $APP_SVC_NAME-db-config --from-literal=JDBC_URL=jdbc:mysql://$DB_SV_NAME.myproject.svc:3306/petclinic --from-literal=JDBC_USERNAME=petclinic

## create secret for petclinic
oc create secret generic $APP_SVC_NAME-secret --from-literal=JDBC_PASSWORD=$MYSQL_PASSWORD

# create petclinic service
oc new-app --image-stream=myproject/petclinic:latest --name=$APP_SVC_NAME
oc expose svc/$APP_SVC_NAME
oc set env --from=configmap/$APP_SVC_NAME-db-config dc/$APP_SVC_NAME
oc set env --from=secret/$APP_SVC_NAME-secret dc/$APP_SVC_NAME

# get hostname
HOST_NAME=$(oc get route/$APP_SVC_NAME -o custom-columns=HOST:spec.host | tail -n +2)
open http://$HOST_NAME/petclinic

