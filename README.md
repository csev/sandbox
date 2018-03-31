
Check my docker images

  $ docker images

    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    tsugi_dev           latest              116d2bf50c4e        2 minutes ago       674MB
    tsugi_mysql         latest              90f8d82f7070        2 minutes ago       674MB
    tsugi_base          latest              b7199f92080c        3 minutes ago       585MB
    ubuntu              14.04               a35e70164dfb        13 days ago         222MB

https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app

    $ gcloud components install kubectl

    $ gcloud projects list

    PROJECT_ID          NAME        PROJECT_NUMBER
    dev-entropy-186617  My Project  1015051521525
    sandbox-199519      Sandbox     1068837837025

    $ gcloud config list
    [compute]
    region = us-central1
    zone = us-central1-b
    [core]
    account = drchuck@learnxp.com
    disable_usage_reporting = False
    project = sandbox-199519

https://cloud.google.com/container-registry/docs/pushing-and-pulling

    docker tag tsugi_mysql:latest us.gcr.io/sandbox-199519/tsugi_mysql:latest

    gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_mysql:latest

    gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_mysql
    DIGEST        TAGS  TIMESTAMP
    97c32f87376e  latest  2018-03-22T00:17:31

https://cloud.google.com/compute/docs/gcloud-compute/

    $ gcloud container clusters list
    NAME        LOCATION       MASTER_VERSION  MASTER_IP      MACHINE_TYPE  NODE_VERSION  NUM_NODES  STATUS
    sandbox-01  us-central1-a  1.8.8-gke.0     35.226.30.123  g1-small      1.8.8-gke.0   2          RUNNING

    $ gcloud config set compute/zone us-central1-a
    $ gcloud container clusters get-credentials sandbox-01 us-central1-a
    Fetching cluster endpoint and auth data.
    kubeconfig entry generated for sandbox-01.

    $ gcloud compute instances list
    NAME                                       ZONE           MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
    gke-sandbox-01-default-pool-dabaf260-4x5w  us-central1-a  g1-small                   10.128.0.3   35.188.154.197  RUNNING
    gke-sandbox-01-default-pool-dabaf260-tjfs  us-central1-a  g1-small                   10.128.0.2   35.225.226.39   RUNNING
    0587365031:docker csev$ gcloud compute instances describe gke-sandbox-01-default-pool-dabaf260-4x5w

    $ gcloud compute instances describe gke-sandbox-01-default-pool-dabaf260-4x5w --zone us-central1-a
    canIpForward: true
    ...

    $ gcloud compute ssh gke-sandbox-01-default-pool-dabaf260-4x5w --zone us-central1-a


    $ kubectl run mysql --image=us.gcr.io/sandbox-199519/tsugi_mysql:latest --port 80 --env="TSUGI_SERVICENAME=TSFUN" --env="WAIT_FOREVER=Yes"

    $ kubectl get pods
    NAME                  READY     STATUS              RESTARTS   AGE
    mysql-9b7666dc4-gf9hs   0/1       ContainerCreating   0          20s


    $ kubectl logs -f mysql-9b7666dc4-gf9hs

    $ kubectl get deployments
    NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    mysql       1         1         1            0           1h
    $ kubectl delete deployment mysql
    deployment "mysql" deleted

    $ kubectl get deployments
    No resources found.
    $ kubectl get pods
    No resources found.

    $ gcloud container images delete us.gcr.io/sandbox-199519/tsugi_mysql:latest

YML

    $ kubectl create -f mysql.yml

    $ kubectl delete -f mysql.yml

