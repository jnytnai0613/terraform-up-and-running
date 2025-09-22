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

### 5. ALB用Security Groupデプロイ
ECS Serviceデプロイ時にALB用とECS用のSecurity Groupを作成したいが、ECS用のSecurity GroupでALB用Security Group Arnを許可している。ALB用Security Group Arnはデプロイしないと決まらないため、以下エラーが発生する。  
+++++++++++++++++++  
The "for_each" map includes keys derived from resource attributes that cannot be determined until apply, and so Terraform cannot determine the full set of keys that will identify the instances of this resource.
When working with unknown values in for_each, it's better to define the map keys statically in your configuration and place apply-time results only in the map values.
Alternatively, you could use the -target planning option to first apply only the resources that the for_each value depends on, and then apply a second time to fully converge.
+++++++++++++++++++  
よって最初に以下コマンドでALB用Security Groupを作成する
```sh
cd systems/ecs/service
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
