# Deploy ingress-nginx

1. apply trait edge-nginx definition
```shell
vela def apply edge-nginx-ingress.cue
```

2. apply application
```shell
vela up -f app.yaml
```