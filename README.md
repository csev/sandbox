

gcloud projects list

gcloud config set project sandbox-199519

kubectl config current-context
kubectl config get-contexts

    kubectl config use-context gke_sandbox-199519_us-central1-a_sandbox-01


https://cloud.google.com/container-registry/docs/pushing-and-pulling

    $ docker tag tsugi_dev:latest us.gcr.io/sandbox-199519/tsugi_dev:latest

    $ gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_dev:latest

    $ gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_dev
    DIGEST        TAGS  TIMESTAMP
    97c32f87376e  latest  2018-03-22T00:17:31

    $ gcloud container images list --repository us.gcr.io/sandbox-199519

Cleanup

    $ kubectl delete ing test
    $ kubectl delete service dev
    $ kubectl delete deployment dev

https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app

    $ kubectl create -f dev-deploy.yml

    $ kubectl get pods
    NAME                        READY     STATUS    RESTARTS   AGE
    dev-5dd65fbb76-9c6ss        1/1       Running   0          6s
    dev-5dd65fbb76-jl4pm        1/1       Running   0          6s

    $ kubectl get deployments
    NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    dev         2         2         2            2           13s

    $ kubectl logs -f dev-5dd65fbb76-9c6ss

    $ kubectl exec -it dev-5dd65fbb76-9c6ss -- /bin/bash

    $ kubectl exec -it my-pod --container web -- /bin/bash

Expose Using NodePort
---------------------

The service is not exposed at all.

Be patient when these come up - leave 2 minutes before trying things
You must do a POST to the https://dev.lrnxp.com through CloudFlare

    $ kubectl create -f dev-service-nodeport.yml 
    service "dev" created
    $ kubectl create -f dev-ingress.yml 
    ingress "test" created
    $ kubectl get service
    NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
    dev          NodePort       10.51.252.104   <none>         80:30036/TCP   8m
    kubernetes   ClusterIP      10.51.240.1     <none>         443/TCP        1d
    $ kubectl get ing
    NAME      HOSTS           ADDRESS          PORTS     AGE
    test      dev.lrnxp.net   35.186.244.105   80        2m

Expose Using Local LoadBalancer
-------------------------------

The service is not exposed at all.

Be patient when these come up - leave 2 minutes before trying things
You must do a POST to the https://dev.lrnxp.com through CloudFlare

    $ kubectl create -f dev-service-nodeport.yml 
    service "dev" created
    $ kubectl create -f dev-ingress.yml 
    ingress "test" created
    $ kubectl get service
    NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
    dev          LoadBalancer   10.51.247.24    10.128.0.6     80:31755/TCP   2m
    kubernetes   ClusterIP      10.51.240.1     <none>         443/TCP        1d
    $ kubectl create dev-ingress.yml 
    error: unknown command "dev-ingress.yml"
    See 'kubectl create -h' for help and examples.
    $ kubectl create -f dev-ingress.yml 
    ingress "test" created
    $ kubectl get ing
    NAME      HOSTS           ADDRESS          PORTS     AGE
    test      dev.lrnxp.net   35.186.212.164   80        10m

Expose Using External LoadBalancer
----------------------------------

The service gets an external IP.

Be patient when these come up - leave 2 minutes before trying things
You must do a POST to the https://dev.lrnxp.com through CloudFlare

    $ kubectl create -f dev-service-loadbalancer.yml 
    service "dev" created
    $ kubectl get service
    NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
    dev          LoadBalancer   10.51.247.24    10.128.0.6     80:31755/TCP   2m
    kubernetes   ClusterIP      10.51.240.1     25.141.16.12   443/TCP        1d

    $ kubectl create -f dev-ingress.yml 
    ingress "test" created
    $ kubectl get ing
    NAME      HOSTS           ADDRESS          PORTS     AGE
    test      dev.lrnxp.net   35.186.244.105   80        9m

You can use the ingress address in CloudFlare or the LoadBalancer address directly 
to the service.

http://25.141.16.12

Make a new version, build, retag, and push the container up to Google

    $ kubectl replace --force -f dev-deploy.yml
    pod "dev" deleted
    pod "dev" replaced

