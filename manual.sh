
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


# kustomize
## https://ellis-wu.github.io/2018/07/26/kustomize-introduction/
## https://www.qikqiak.com/post/kustomize-101/
# install kustomize
brew install kustomize

# tekton
## tekton tutorial
## https://tekton.dev/docs/
## https://tekton.dev/docs/getting-started/tasks/
## https://blog.cti.app/archives/5829

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

