#!/bin/bash

kubectl run nginx --image=nginx
kubectl expose deployment nginx --name=sys-orangeapi --port=80 --target-port=80

kubectl run echoserver --image=gcr.io/google_containers/echoserver:1.4
kubectl expose deployment echoserver --name=orangesys-kong-proxy --port=80 --target-port=8080
