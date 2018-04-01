
My First Apache on Kubernetes
-----------------------------

I got a lot of inspiration from https://github.com/profmikegreene/kechirase-los-lobos/tree/master/tsugi

    $ docker build --tag cs_apache .

    $ docker run -p 8080:80 -e TSUGI_SERVICENAME=TSFUN -dit cs_apache:latest
    4612ec1abc449862af26c363446b2d33a3e69f971bf54b4cf75ddc91067096c7

    # Don't attach or it will kill it

    $ docker ps
    CONTAINER ID        IMAGE               COMMAND                  PORTS                  NAMES
    19ce19f27aaf        cs_apache:latest    "docker-php-entrypoi…"   0.0.0.0:8080->80/tcp   affectionate_chatterjee
    $ docker exec -i -t 19ce19f27aaf /bin/bash
    root@19ce19f27aaf:/var/www/html# 

Navigate to http://localhost:8080

    $ docker stop 19ce19f27aaf
    $ docker container prune
    
    $ docker rmi 598d9defded1

    # You can also build a new docker and then cleanup untagged images
    $ docker image prune

On to Kubernetes

    $ docker tag cs_apache:latest us.gcr.io/sandbox-199519/cs_apache:latest

    $ docker images
    REPOSITORY                            TAG                 IMAGE ID            CREATED             SIZE
    cs_apache                             latest              0b13b5a7bdcc        5 minutes ago       506MB
    us.gcr.io/sandbox-199519/cs_apache    latest              0b13b5a7bdcc        5 minutes ago       506MB
    php                                   7.2-apache          2b5d510e3cf2        9 days ago          378MB

    $ gcloud docker -- push us.gcr.io/sandbox-199519/cs_apache:latest

    $ gcloud container images list-tags us.gcr.io/sandbox-199519/cs_apache
    DIGEST        TAGS    TIMESTAMP
    311d36495a0c  latest  2018-04-01T10:14:46

Double check nothing running...

    $ kubectl get deployment
    No resources found.
    $ kubectl get service
    NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
    kubernetes   ClusterIP   10.51.240.1   <none>        443/TCP   48m

    $ kubectl run cs-apache --image=us.gcr.io/sandbox-199519/cs_apache:latest --port 80
    deployment "cs-apache" created

    $ kubectl get pods

    $ kubectl logs cs-apache-86b76c695-xsdzg 
    AH00558: apache2: Could not reliably determine the server's fully qualified ...
    AH00558: apache2: Could not reliably determine the server's fully qualified ...
    [Sun Apr 01 14:27:13.002123 2018] [mpm_prefork:notice] [pid 1] AH00163: ...
    [Sun Apr 01 14:27:13.002392 2018] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'

    $ kubectl get deployments
    NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    cs-apache   1         1         1            1           2m

    $ kubectl expose deployment cs-apache --type=LoadBalancer --port 80 --target-port 80
    service "cs-apache" exposed

    $ kubectl get service
    NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
    cs-apache    LoadBalancer   10.51.255.154   <pending>     80:31105/TCP   22s
    kubernetes   ClusterIP      10.51.240.1     <none>        443/TCP        54m

    # A minute later
    $ kubectl get service
    NAME         TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
    cs-apache    LoadBalancer   10.51.255.154   35.192.51.116   80:31105/TCP   1m
    kubernetes   ClusterIP      10.51.240.1     <none>          443/TCP        54m

    $ kubectl get pods
    NAME                        READY     STATUS    RESTARTS   AGE
    cs-apache-86b76c695-xsdzg   1/1       Running   0          11m

    $ kubectl exec -it cs-apache-86b76c695-xsdzg -- /bin/bash
    root@cs-apache-86b76c695-xsdzg:/var/www/html# ls
    index.html

    $ kubectl delete service cs-apache
    service "cs-apache" deleted


