# refernce: https://community.hetzner.com/tutorials/install-kubernetes-cluster
kubeadm config images pull

kubeadm init --config=kubeadm_init.yml

mkdir -p /root/.kube
cp -i /etc/kubernetes/admin.conf /root/.kube/config

kubectl apply -f kube-system_init.yml

# Supplied by Hetzner 
kubectl apply -f deploy_hetzner_cloud_controller.yml

kubectl apply -f cluster_networking.yml

kubectl -n kube-flannel patch ds kube-flannel-ds --type json -p '[{"op":"add","path":"/spec/template/spec/tolerations/-","value":{"key":"node.cloudprovider.kubernetes.io/uninitialized","value":"true","effect":"NoSchedule"}}]'

kubectl -n kube-system patch deployment coredns --type json -p '[{"op":"add","path":"/spec/template/spec/tolerations/-","value":{"key":"node.cloudprovider.kubernetes.io/uninitialized","value":"true","effect":"NoSchedule"}}]'

kubectl apply -f hetzner_cloud_container_storage_interface.yml

# next line is optional if token needs to be recreated
#kubeadm token create --print-join-command
