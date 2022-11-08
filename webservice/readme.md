# Deploy a simple webservice

1. apply trait replica-webservice 
```shell
vela def apply replica-webservice.cue
```

2. apply application
```shell
vela up -f app.yaml
```