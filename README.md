本リポジトリはECSを中心としたインフラ環境のIaCコードです。

## デプロイ方法
### 1. VPCデプロイ
```sh
cd systems/vpc
terarform init
terraform apply
```

### 2. ECRデプロイ
```sh
cd systems/ecr
terarform init
terraform apply
```

### 3. ECS Clusterデプロイ
```sh
cd systems/ecs/cluster
terarform init
terraform apply
```

### 4. ECS タスク定義デプロイ
```sh
cd systems/ecs/task
terarform init
terraform apply
```

### 5. ALBデプロイ
```sh
cd systems/ecs/service/alb
terarform init
terraform apply -target=module.alb_security_group
```

### 6. ECS Serviceデプロイ
```sh
cd systems/ecs/service
terarform init
terraform apply
```

### 7. GitHub Actions用OIDCロールデプロイ
```sh
cd systems/iam/provider/oidc/github
terarform init
terraform apply
```

### 8. GitHub Actions用OIDCロールデプロイ
```sh
cd systems/iam/role/oidc/github
terarform init
terraform apply
```
