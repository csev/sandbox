
https://cloud.google.com/container-registry/docs/pushing-and-pulling

    $ docker tag tsugi_dev:latest us.gcr.io/sandbox-199519/tsugi_dev:latest

    $ gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_dev:latest

    $ gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_dev
    DIGEST        TAGS  TIMESTAMP
    97c32f87376e  latest  2018-03-22T00:17:31

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

    # Service Fail #1 - Can't even talk to the LB address
    $ kubectl create -f service-dev-loadbalancer.yml

    # Service Fail #2 - Had no address, ingress does not work
    $ kubectl expose deployment dev --type=NodePort --port 80 --target-port 80

    # Service Success - Works for direct IP and ingress IP (behind cloudflare)
    $ kubectl expose deployment dev --type=LoadBalancer --port 80 --target-port 80

    $ kubectl get services
    NAME         TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
    dev          LoadBalancer   10.51.249.6     35.188.25.102   80:30406/TCP   40s
    kubernetes   ClusterIP      10.51.240.1     <none>          443/TCP        13h

    # Can navigate to http://35.188.25.102

    $ kubectl create -f dev-ingress.yml
    ingress "test" created

    $ kubectl get ing
    NAME      HOSTS           ADDRESS          PORTS     AGE
    test      dev.lrnxp.net   35.186.244.105   80        1m

    # Can navigate to https://dev.lrnxp.net  (via cloudflare after DNS setup)

Make a new version, build, retag, and push the container up to Google

    $ kubectl replace --force -f dev-deploy.yml
    pod "dev" deleted
    pod "dev" replaced

