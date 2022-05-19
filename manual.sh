
# prepare spring boot hello world
## https://spring.io/guides/gs/spring-boot-docker/

# build docker image
docker build -t dolun1119/spring-boot-demo .

# run & see it works or not
docker run --name spring-boot-demo -p 8080:8080 dolun1119/spring-boot-demo


# push image to docker repository
docker push dolun1119/spring-boot-demo
curl http://localhost:8080


# minikube tutorial
## https://medium.com/starbugs/kubernetes-%E6%95%99%E5%AD%B8-02-%E5%9C%A8-minikube-%E4%B8%8A%E9%83%A8%E5%B1%AC%E4%B8%80%E5%80%8B-python-flask-%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F-e7a3b9448f2c

## https://blog.kennycoder.io/2020/12/13/Kubernetes%E6%95%99%E5%AD%B8%E7%B3%BB%E5%88%97-%E5%A6%82%E4%BD%95%E5%BB%BA%E7%AB%8BPod/

# install minikube
brew install minikube 

# common kubectl commands
kubectl get all

kubectl get pods

kubectl delete pod kubernetes-demo-pod

kubectl create -f demo-pod.yaml
kubectl create -f demo-service.yaml

kubectl port-forward kubernetes-demo-pod 3000:8080

kubectl expose pod kubernetes-demo-pod --type=NodePort --name=demo-service

# forward service port
kubectl port-forward service/demo-service 8080:8080

docker exec -it 5c3cf05ba1c3 /bin/bash
curl http://localhost:30633

# k8s
## https://iter01.com/topic/143.html

# kustomize
## https://ellis-wu.github.io/2018/07/26/kustomize-introduction/
## https://zhuanlan.zhihu.com/p/92153378
## https://www.qikqiak.com/post/kustomize-101/
## https://www.densify.com/kubernetes-tools/kustomize
# install kustomize
brew install kustomize

# tekton
## tekton tutorial
## https://tekton.dev/docs/
## https://tekton.dev/docs/getting-started/tasks/
## https://blog.cti.app/archives/5829
https://tekton.dev/vault/pipelines-v0.31.x/
## Tekton Hello World
https://knative-sample.com/10-getting-started/60-tekton-hello-world/

# install tekton to kubernetes
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# monitor tekton installation
kubectl get pods --namespace tekton-pipelines --watch

# create a task with yaml file
kubectl apply --filename /Users/shaolun.chen/Desktop/k8s/demo-tekton-task.yaml
kubectl apply -f demo-tekton-task.yaml

# list task
kubectl get task

# describe task
kubectl describe task hello

# create a taskrun with yaml file
kubectl apply --filename demo-tekton-taskrun.yaml
kubectl apply -f demo-tekton-taskrun.yaml

# list taskrun
kubectl get taskrun
kubectl get taskrun hello-task-run

# check taskrun log
kubectl logs --selector=tekton.dev/taskRun=hello-task-run

## tekton dashboard
https://github.com/tektoncd
## install tekton dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
# monitor tekton dashboard installation (Note: Hit CTRL+C to stop monitoring.)
kubectl get pods --namespace tekton-pipelines --watch
# forward dashboard service port
kubectl port-forward svc/tekton-dashboard 8097:9097 -n tekton-pipelines
# go tekton-dashboard
http://localhost:8097/


## integration 
https://cloud.tencent.com/developer/article/1815076


# my repository
https://gitpub.rakuten-it.com/scm/~shaolun.chen/shaolun-helloworld


# tekton
https://atbug.com/how-tekton-works/
https://atbug.com/tekton-pipeline-practice/
# Tekton实现java项目部署到k8s的完整CICD流程
https://cloud.tencent.com/developer/article/1815076
# 可視化 Tekton 組件 Tekton Dashboard
https://blog.cti.app/archives/5829

# docker with java maven
https://migueldoctor.medium.com/how-to-create-a-custom-docker-image-with-jdk8-maven-and-gradle-ddc90f41cee4
# docker build flow for java
https://codefresh.io/docker-tutorial/java_docker_pipeline/


https://godleon.github.io/blog/DevOps/tekton-pipeline-building-blocks/


kubectl create secret docker-registry dockerhub --docker-server=https://index.docker.io/v1/ --docker-username=[USERNAME] --docker-password=[PASSWORD] --dry-run=client -o json | jq -r '.data.".dockerconfigjson"' | base64 -d > /tmp/config.json && kubectl create secret generic docker-config --from-file=/tmp/config.json && rm -f /tmp/config.json
kubectl create secret docker-registry dockerhub --docker-server=https://index.docker.io/v1/ --docker-username=[USERNAME] --docker-password=[PASSWORD] --dry-run=client -o json
kubectl create secret docker-registry dockerhub --docker-server=https://index.docker.io/v1/ --docker-username='dolun1119@gmail.com' --docker-password='!QAZ2wsx3edc' --dry-run=client -o json | jq -r '.data.".dockerconfigjson"' | base64 -d > /tmp/config.json && kubectl create secret generic docker-config --from-file=/tmp/config.json && rm -f /tmp/config.json
kubectl create secret docker-registry dockerhub --docker-server=https://index.docker.io/v1/ --docker-username='dolun1119@gmail.com' --docker-password='!QAZ2wsx3edc' --dry-run=client -o json

