https://www.weave.works/docs/scope/latest/installing/#k8s
安装命令
kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"
