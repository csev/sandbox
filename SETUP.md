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

