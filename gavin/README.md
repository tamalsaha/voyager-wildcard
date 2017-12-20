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

```console
~/g/s/g/t/v/gavin (master) $ curl -vv 192.168.99.100:31059 -H "Host: sysapi.example.com"
* Rebuilt URL to: 192.168.99.100:31059/
*   Trying 192.168.99.100...
* Connected to 192.168.99.100 (192.168.99.100) port 31059 (#0)
> GET / HTTP/1.1
> Host: sysapi.example.com
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.13.7
< Date: Wed, 20 Dec 2017 06:19:23 GMT
< Content-Type: text/html
< Content-Length: 612
< Last-Modified: Tue, 21 Nov 2017 14:28:04 GMT
< ETag: "5a1437f4-264"
< Accept-Ranges: bytes
< 
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
* Connection #0 to host 192.168.99.100 left intact
```

```console
$ curl -vv 192.168.99.100:31059 -H "Host: app.g.example.com"
* Rebuilt URL to: 192.168.99.100:31059/
*   Trying 192.168.99.100...
* Connected to 192.168.99.100 (192.168.99.100) port 31059 (#0)
> GET / HTTP/1.1
> Host: app.g.example.com
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.10.0
< Date: Wed, 20 Dec 2017 06:19:55 GMT
< Content-Type: text/plain
< Transfer-Encoding: chunked
< 
CLIENT VALUES:
client_address=172.17.0.7
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://app.g.example.com:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
connection=close
host=app.g.example.com
user-agent=curl/7.47.0
x-forwarded-for=172.17.0.1
BODY:
* Connection #0 to host 192.168.99.100 left intact
```
