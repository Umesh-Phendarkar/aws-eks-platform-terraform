# aws-eks-platform-terraform
Above is the Repo Structure we have to follow:-
aws-eks-platform-terraform/
│
├── README.md
├── .gitignore
├── backend.tf
├── providers.tf
├── variables.tf
├── outputs.tf
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │
│   ├── prod/
│       ├── main.tf
│       ├── terraform.tfvars
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│
│   ├── nodegroup/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│
│   ├── security/
│   │   ├── main.tf
│   │   ├── variables.tf
│
├── scripts/
│   ├── deploy.sh
│   ├── destroy.sh
│
├── ci-cd/
│   ├── github-actions.yml
│
└── docs/
    ├── architecture.png
    ├── design.md
