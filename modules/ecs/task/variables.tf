variable "task_cpu_allocation" {
  description = "タスクのCPU割り当て(1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "task_memory_allocation" {
  description = "タスクのメモリ割り当て(MB単位)"
  type        = number
  default     = 2048
}

variable "task_role_arn" {
  description = "タスク内のコンテナが引き受けることができるIAMロールのARN。"
  type        = string
}

variable "task_exec_role_arn" {
  description = "Amazon ECSコンテナエージェントとDockerデーモンが引き受けることができるタスク実行ロールのARN。"
  type        = string
}

variable "container_definitions" {
  description = "タスクを構成するさまざまなコンテナを説明するJSON形式のコンテナ定義のリスト。"
  type        = string
  default     = <<DESC
[
    {
        "name": "nginx",
        "image": "nginx:latest",
        "cpu": 1024,
        "memory": 2048,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ]
    }
]
DESC
  validation {
    condition     = can(jsondecode(var.container_definitions))
    error_message = "The container_definitions must be a valid JSON string."
  }
}

variable "service_name" {
  description = "サービス名"
  type        = string
}

variable "service_sufix" {
  description = "Service Suffix（サブサービス名やコンポーネント名など)"
  type        = string
  default     = ""
}

variable "env" {
  description = "環境識別子(dev, staging, prodなど)"
  type        = string
  default     = "dev"
}

variable "task_additional_tags" {
  description = "タスク定義に追加するタグのマップ"
  type        = map(string)
  default     = {}

  validation {
    condition = length(setintersection(keys(var.task_additional_tags), [
      "Name",
      "Environment",
      "ServiceName",
      "ServiceSuffix",
    ])) == 0
    error_message = "Key names, Name and Environment, ServiceName and ServiceSuffix are reserved. Not allowed to use them."
  }
}
