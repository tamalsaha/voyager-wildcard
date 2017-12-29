1. Deploy voyager operator.

```console
curl -fsSL https://raw.githubusercontent.com/appscode/voyager/5.0.0-rc.10/hack/deploy/voyager.sh \
    | bash -s -- --provider=gke
```

Then update voyager-operator deployment in kube-system namespace to change image to `appscode/voyager:wildcard-tls`

2. First deploy the test servers using ./deploy-servers.sh script.

3. Now, create an Ingress object running `kubectl apply -f ing-http.yaml`

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


4. Create Acme user secret . I am using LE staging environment here for testing. So, issued certs will not be trusted by browser.

```console
kubectl create secret generic acme-account \
  --from-literal=ACME_EMAIL=me@example.com \
  --from-literal=ACME_SERVER_URL=https://acme-staging.api.letsencrypt.org/directory
```

5. Create certificate.

```console
kubectl apply -f crt.yaml
```

6. Update Ingress to add `spec.tls` fields.

```console
kubectl apply -f ing-https.yaml
```

Visit URLs:
 - http://kiteci.com
 - http://app1.kiteci.com
 - http://app2.kiteci.com
 - http://www.kiteci.com
