
docker tag tsugi_base:latest us.gcr.io/sandbox-199519/tsugi_base:latest
docker tag tsugi_kube:latest us.gcr.io/sandbox-199519/tsugi_kube:latest
docker tag tsugi_mysql:latest us.gcr.io/sandbox-199519/tsugi_mysql:latest
docker tag tsugi_dev:latest us.gcr.io/sandbox-199519/tsugi_dev:latest

gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_base:latest
gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_kube:latest
gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_mysql:latest
gcloud docker -- push us.gcr.io/sandbox-199519/tsugi_dev:latest

gcloud container images list --repository us.gcr.io/sandbox-199519

gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_dev
gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_kube
gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_mysql
gcloud container images list-tags us.gcr.io/sandbox-199519/tsugi_dev

