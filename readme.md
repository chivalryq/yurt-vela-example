# Yurt-Vela-Example

This repository stores some examples of deploying application with both KubeVela and OpenYurt. 

## Preparation for all examples

#### 1.Install Yurt App Manager

```shell
git clone git@github.com:openyurtio/yurt-app-manager.git
cd yurt-app-manager && helm install yurt-app-manager -n kube-system ./charts/yurt-app-manager/
```

#### 2. Create nodepool CR
```shell
kubectl apply -f nodepool.yaml
```

#### 3. add node to nodepool
```shell
kubectl label node <node1> apps.openyurt.io/desired-nodepool=shanghai
kubectl label node <node2> apps.openyurt.io/desired-nodepool=beijing
```

#### 4. check nodepool
```shell
kubectl get nodepool
```
expected output
```shell
NAME       TYPE   READYNODES   NOTREADYNODES   AGE
beijing    Edge   1            0               6m2s
shanghai   Edge   1            0               6m1s
```

## Examples

1. [Deploy a webservice](./webservice/readme.md)
2. [Deploy a ingress nginx](./ingress-nginx/readme.md)
3. [Deploy a nginx gateway](./gateway-nginx/readme.md)

