# CAREFUL!!! HAVEN'T TESTED THIS YET ITS ONLY THE COLLECTION OF THE TUTORIAL

# Initilazing Kubernetes on Hetzner Server

1. Setup all Hetzner Server, Networks and Floating IP address: link[https://community.hetzner.com/tutorials/install-kubernetes-cluster]

2. Create .env file and copy the example content accordingly

3. Delete all files you don't need (git folder, .env.example and README)
local:
```bash
rm -rf .git .gitignore .env.example README.md
```

4. Copy all files onto you master node
local:
```bash
scp -r kubernetes_init_master root@<master-ip-address>:/root/
```

5. Execute sh file to create master node
master:
```bash
sh /root/kubernetes_init_master/init_kubernetes_master.sh
```

6. Copy config file to you machine
local:
```bash
scp root@<master-ip-address>:/etc/kubernetes/admin.conf ${HOME}/.kube/config
```

7. now you can use kubectl commands from your local machines to initialise new pods and so on...

8. Get join command
master:
```bash
kubeadm token create --print-join-command
```

copy the output

9. and paste it onto every worker node (this is just what it should look like)
worker:
```bash
kubeadm join <master-ip-address>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
```

10. Check if it worked
local:
```bash
kubectl get nodes
```
should look like this
```
NAME       STATUS   ROLES    AGE   VERSION
master-1   Ready    master   11m   v1.27.1
worker-1   Ready    <none>   5m    v1.27.1
worker-2   Ready    <none>   5m    v1.27.1
```
