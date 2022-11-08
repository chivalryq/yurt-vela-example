# Deploy Nginx Kubernetes Gateway

1. apply trait edge-nginx-gateway definition
```shell
vela def apply edge-nginx-gateway.cue
```

2. apply application
```shell
vela up -f app.yaml
```