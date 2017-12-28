#!/bin/bash

kubectl run nginx --image=nginx
kubectl expose deployment nginx --name=web --port=80 --target-port=80
