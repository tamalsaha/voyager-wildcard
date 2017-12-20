1. Deploy voyager operator.

```console
curl -fsSL https://raw.githubusercontent.com/appscode/voyager/5.0.0-rc.7/hack/deploy/voyager.sh \
    | bash -s -- --provider=minikube
```

2. First deploy the test servers using ./deploy-servers.sh script.

3. Now, create an Ingress object running `kubectl apply -f ing.yaml`

```console
$ kubectl get pods,svc
NAME                                            READY     STATUS    RESTARTS   AGE
po/echoserver-566fcc4fdb-v8xj5                  1/1       Running   0          26m
po/nginx-d5dc44cf7-dq7p7                        1/1       Running   0          26m
po/voyager-g-example-ingress-84cb55b5f4-65z82   1/1       Running   0          26s

NAME                            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
svc/kubernetes                  ClusterIP   10.96.0.1        <none>        443/TCP        1h
svc/orangesys-kong-proxy        ClusterIP   10.111.95.187    <none>        80/TCP         1m
svc/sys-orangeapi               ClusterIP   10.110.119.33    <none>        80/TCP         1m
svc/voyager-g-example-ingress   NodePort    10.102.152.174   <none>        80:31059/TCP   31s

$ minikube ip
192.168.99.100
```


Visit URLs:
 - https://sysapi.kiteci.com
 - https://app1.g.kiteci.com
 - https://app2.g.kiteci.com
