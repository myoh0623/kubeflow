#!/bin/bash
# init k8s
sudo kubeadm init --pod-network-cidr=10.217.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


kubectl cluster-info

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/v0.13.0/Documentation/kube-flannel.yml

kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/1.0.0-beta6/nvidia-device-plugin.yml


#test GPU
kubectl -n kube-system get pod -l name=nvidia-device-plugin-ds
kubectl -n kube-system logs  -l name=nvidia-device-plugin-ds

# default storageclass
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
kubectl get storageclass
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get sc

# install kusomize 
wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.10.0/kustomize_v3.10.0_linux_amd64.tar.gz
tar -zxvf kustomize_v3.10.0_linux_amd64.tar.gz
sudo chmod 777 kustomize
sudo mv kustomize /usr/local/bin

# autocomplete k8s

sudo apt-get install bash-completion -y
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc
/bin/bash
