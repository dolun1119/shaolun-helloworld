

### weekly sharing

# k8s
## VS Code yaml error message
# https://stackoverflow.com/questions/64080471/one-or-more-containers-do-not-have-resource-limits-warning-in-vs-code-kubernet
kubectl 
# CustomResourceDefinition(CRD)

# docker
## 1. prepare spring boot hello world
https://spring.io/guides/gs/spring-boot-docker/
## 2. build docker image
docker build -t dolun1119/spring-boot-demo .
## 3. run & see if it works
docker run --name spring-boot-demo -p 8080:8080 dolun1119/spring-boot-demo
curl http://localhost:8080
## 4. push image to docker repository
docker push dolun1119/spring-boot-demo

# Kubernetes k8s
### Kubernetes 基礎教學（一）原理介紹
https://cwhu.medium.com/kubernetes-basic-concept-tutorial-e033e3504ec0
### Kubernetes 教學系列 - 如何建立 Pod
https://blog.kennycoder.io/2020/12/13/Kubernetes%E6%95%99%E5%AD%B8%E7%B3%BB%E5%88%97-%E5%A6%82%E4%BD%95%E5%BB%BA%E7%AB%8BPod/
### IT人
https://iter01.com/topic/143.html

# minikube
## tutorial
### minikube tutorial
https://medium.com/starbugs/kubernetes-%E6%95%99%E5%AD%B8-02-%E5%9C%A8-minikube-%E4%B8%8A%E9%83%A8%E5%B1%AC%E4%B8%80%E5%80%8B-python-flask-%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F-e7a3b9448f2c
### minikube Accessing apps
https://minikube.sigs.k8s.io/docs/handbook/accessing/

## install minikube
brew install minikube 
## check
minikube start
minikube status
minikube ssh

# common kubectl commands
kubectl get all
kubectl get pods

# git clone https://github.com/dolun1119/shaolun-helloworld.git
vi minikube-demo/demo-pod.yaml
kubectl apply -f minikube-demo/demo-pod.yaml
kubectl port-forward kubernetes-demo-pod 3000:8080
curl http://localhost:3000
kubectl delete pod kubernetes-demo-pod

vi minikube-demo/demo-service.yaml
kubectl apply -f minikube-demo/demo-service.yaml
kubectl get all
kubectl port-forward service/shaolun-service 8080:8080
curl http://localhost:8080
kubectl delete deployment.apps/hello-app
kubectl delete service/shaolun-service


# kustomize
## Kustomize Tutorial
https://www.densify.com/kubernetes-tools/kustomize
## 使用 Kustomize 管理 Kubernetes 配置檔
https://ellis-wu.github.io/2018/07/26/kustomize-introduction/
## kustomize 最简实践
https://zhuanlan.zhihu.com/p/92153378
## 使用 Kustomize 配置 Kubernetes 应用
https://www.qikqiak.com/post/kustomize-101/

# kustomize 概念

# install kustomize
brew install kustomize

tree kustomize-demo/
# kustomize-demo/
# ├── base
# │   ├── configMap.yaml
# │   ├── deployment.yaml
# │   ├── kustomization.yaml
# │   └── service.yaml
# └── overlays
#     ├── production
#     │   ├── deployment.yaml
#     │   └── kustomization.yaml
#     └── staging
#         ├── kustomization.yaml
#         └── map.yaml

# 4 directories, 8 files

## build kustomize config yaml
kustomize build kustomize-demo/base
kustomize build kustomize-demo/overlays/staging
kustomize build kustomize-demo/overlays/production

## build kustomize config yaml & apply
kustomize build kustomize-demo/base | kubectl apply -f -
kustomize build kustomize-demo/overlays/staging | kubectl apply -f -
kustomize build kustomize-demo/overlays/production | kubectl apply -f -
## apply with kubectl
kubectl apply -k kustomize-demo/overlays/staging


# tekton
https://github.com/tektoncd

### docker with java maven
https://migueldoctor.medium.com/how-to-create-a-custom-docker-image-with-jdk8-maven-and-gradle-ddc90f41cee4
### docker build flow for java
https://codefresh.io/docker-tutorial/java_docker_pipeline/

## tekton tutorial
https://tekton.dev/docs/
### Tekton Hello World
https://knative-sample.com/10-getting-started/60-tekton-hello-world/
https://atbug.com/how-tekton-works/
https://atbug.com/tekton-pipeline-practice/
https://github.com/addozhang/tekton-test/tree/main/tekton
### Tekton实现java项目部署到k8s的完整CICD流程
https://cloud.tencent.com/developer/article/1815076
### Tekton example
https://blog.cti.app/archives/5829
https://github.com/sunny0826/pipeline-example-maven
### tekton pipeline example
https://www.51cto.com/article/703642.html
### jenkins -> tekton
https://www.51cto.com/article/704400.html
### tekton element
https://godleon.github.io/blog/DevOps/tekton-pipeline-building-blocks/

https://github.com/jasonsmithio/cncf-pipeline-demo/tree/main/tekton
# kaniko
https://github.com/GoogleContainerTools/kaniko/blob/main/README.md#pushing-to-docker-hub
https://github.com/GoogleContainerTools/kaniko#pushing-to-docker-hub

## install tekton to kubernetes
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

## monitor tekton installation
kubectl get pods --namespace tekton-pipelines --watch

## tekton dashboard
https://github.com/tektoncd
## install tekton dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
## monitor tekton dashboard installation (Note: Hit CTRL+C to stop monitoring.)
kubectl get pods --namespace tekton-pipelines --watch
## forward dashboard service port
kubectl port-forward svc/tekton-dashboard 8097:9097 -n tekton-pipelines
## go tekton-dashboard
http://localhost:8097/

# demo
## task
vi tekton/demo/test-task.yaml
kubectl apply -f tekton/demo/test-task.yaml
## taskrun
vi tekton/demo/test-taskrun.yaml
kubectl apply -f tekton/demo/test-taskrun.yaml

kubectl describe task hello

kubectl get task
kubectl get taskrun
kubectl get taskrun hello-task-run
kubectl get pipeline
kubectl get pipelinerun

# demo pipeline
vi tekton/pipeline/build-pipeline.yaml
kubectl apply -f tekton/pipeline/build-pipeline.yaml

## 1. clone from git => git-clone task

## 2.1 maven build
## 2.2 build & push docker image
vi tekton/task/source-to-image.yaml
kubectl apply -f tekton/task/source-to-image.yaml

## 3. deploy
vi tekton/task/deploy-to-k8s.yaml
kubectl apply -f tekton/task/deploy-to-k8s.yaml

## 4. pipelineRun
vi tekton/run/run.yaml
# execute pipeline
kubectl apply -f tekton/run/run.yaml

## prepare config.json
kubectl create secret docker-registry dockerhub --docker-server=https://index.docker.io/v1/ --docker-username=[USERNAME] --docker-password=[PASSWORD] --dry-run=client -o json | jq -r '.data.".dockerconfigjson"' | base64 -d > /tmp/config.json && kubectl create secret generic docker-config --from-file=/tmp/config.json && rm -f /tmp/config.json

# forward load balancer
kubectl port-forward service/staging-the-service 3000:8666

