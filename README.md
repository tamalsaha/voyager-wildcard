```console
$ kubectl get pods,svc
NAME                                       READY     STATUS    RESTARTS   AGE
po/echoserver-848b75d85-hshcq              1/1       Running   0          2m
po/nginx-7c87f569d-gxftw                   1/1       Running   0          5m
po/voyager-test-ingress-55f9b58b8f-vpfmx   1/1       Running   0          1m

NAME                       CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
svc/kubernetes             10.0.0.1     <none>        443/TCP        7m
svc/rest                   10.0.0.188   <none>        80/TCP         2m
svc/voyager-test-ingress   10.0.0.216   <nodes>       80:31656/TCP   1m
svc/web                    10.0.0.11    <none>        80/TCP         5m

$ minikube ip
192.168.99.100
```


```console
$ curl -vv 192.168.99.100:31656 -H "Host: web.example.com"
* Rebuilt URL to: 192.168.99.100:31656/
*   Trying 192.168.99.100...
* Connected to 192.168.99.100 (192.168.99.100) port 31656 (#0)
> GET / HTTP/1.1
> Host: web.example.com
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.13.6
< Date: Mon, 30 Oct 2017 11:17:43 GMT
< Content-Type: text/html
< Content-Length: 612
< Last-Modified: Thu, 14 Sep 2017 16:35:09 GMT
< ETag: "59baafbd-264"
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
$ curl -vv 192.168.99.100:31656 -H "Host: app.example.com"
* Rebuilt URL to: 192.168.99.100:31656/
*   Trying 192.168.99.100...
* Connected to 192.168.99.100 (192.168.99.100) port 31656 (#0)
> GET / HTTP/1.1
> Host: app.example.com
> User-Agent: curl/7.47.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx/1.10.0
< Date: Mon, 30 Oct 2017 11:17:51 GMT
< Content-Type: text/plain
< Transfer-Encoding: chunked
< 
CLIENT VALUES:
client_address=172.17.0.7
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://app.example.com:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
connection=close
host=app.example.com
user-agent=curl/7.47.0
x-forwarded-for=172.17.0.1
BODY:
* Connection #0 to host 192.168.99.100 left intact
```