# Zero-Touch Infrastructure-as-Code Provisioning
A production-grade, automated Infrastructure as Code (IaC) pipeline built with **Terraform**, **AWS**, and **GitHub Actions**. This project demonstrates a complete DevOps lifecycle—from static analysis and remote state locking to fully automated, zero-touch deployments on AWS.

---

## Architecture Overview

```text
                           +-------------------------------------------------+
                           |                 GitHub Actions                  |
                           |  (CI/CD Engine with AWS Secrets Authentication)  |
                           +------------------------+------------------------+
                                                    |
                                                    | Automated Plan & Apply
                                                    v
+---------------------------------------------------------------------------------------------------+
| AWS Cloud (us-east-1)                                                                             |
|                                                                                                   |
|  +-----------------------------------+               +-----------------------------------------+  |
|  | Remote State Management           |               | Virtual Private Cloud (VPC) 10.0.0.0/16 |  |
|  |  - S3 Bucket (Encrypted & Versioned)|               |                                         |  |
|  |  - DynamoDB Table (State Locking) |               |  +-----------------------------------+  |  |
|  +-----------------------------------+               |  | Public Subnet (10.0.1.0/24)       |  |  |
|                                                      |  |  - Internet Gateway (IGW) Attached|  |  |
|                                                      |  |  - Web Security Group (Port 80)  |  |  |
|                                                      |  |  - EC2 Instance (Ubuntu + Nginx)  |  |  |
|                                                      |  +-----------------------------------+  |  |
|                                                      |                                         |  |
|                                                      |  +-----------------------------------+  |  |
|                                                      |  | Private Subnet (10.0.2.0/24)      |  |  |
|                                                      |  |  - Isolated Backend Subnet        |  |  |
|                                                      |  +-----------------------------------+  |  |
|                                                      +-----------------------------------------+  |
+---------------------------------------------------------------------------------------------------+
Key Features & Highlights
Automated CI/CD Pipeline: GitHub Actions workflow running static analysis (tflint, terraform fmt, terraform validate), dynamic PR plan commenting, and zero-touch terraform apply on merge.

Remote State & Locking: State stored in an encrypted AWS S3 bucket with versioning enabled and concurrency locking via DynamoDB.

Modular AWS Networking: Custom VPC, Public Subnet, Private Subnet, Internet Gateway (IGW), and Public Route Table associations.

Automated Compute Provisioning: Ubuntu 22.04 LTS EC2 web server provisioned dynamically with automated Nginx web server installation via startup scripts (user_data).

Security First: Stateful Security Groups restricting inbound access exclusively to port 80 (HTTP) while allowing isolated outbound access.
 Repository Structure
Plaintext
zero-touch-iac/
├── .github/
│   └── workflows/
│       └── iac-ci.yml          
├── terraform/
│   ├── backend.tf            
│   ├── backend_resources.tf
│   ├── compute.tf            
│   ├── outputs.tf          
│   ├── variables.tf            
│   └── vpc.tf               
└── README.md               
⚡ CI/CD Pipeline Workflow
Plaintext
[ Developer Push / PR ] ──► [ GitHub Actions Runner ]
                                   │
                                   ├── 1. tflint & terraform fmt
                                   ├── 2. terraform validate
                                   ├── 3. terraform plan (Posts comment preview on PR)
                                   │
                           [ Merge PR to main ]
                                   │
                                   └── 4. terraform apply -auto-approve ──► [ Live AWS Deployment ]
 How to Provision Locally
Prerequisites
Terraform CLI (>= 1.5.0)

AWS CLI configured with valid IAM credentials

Git

Execution Steps
Clone the Repository:
git clone [https://github.com/Abdullah07-creator/zero-touch-iac.git](https://github.com/Abdullah07-creator/zero-touch-iac.git)
cd zero-touch-iac/terraform
Initialize Terraform & Remote Backend:

terraform init
Preview Infrastructure Plan:

terraform plan
Deploy Infrastructure:

terraform apply
Tear Down / Destroy Infrastructure:

terraform destroy
👤 Author
Abdullah - DevOps & Cloud Infrastructure Engineer
