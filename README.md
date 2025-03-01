# Infrastructure Code Repository

This repository contains Terraform configurations and supporting scripts for provisioning AWS infrastructure. It deploys a complete setup including a Virtual Private Cloud (VPC), public subnet, Internet Gateway, Route Table (with association), Security Group, and an EC2 instance with initial provisioning using user data.

## Table of Contents

- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
- [Infrastructure Description](#infrastructure-description)
- [Deployment Process](#deployment-process)
- [Environment Variables and Configuration](#environment-variables-and-configuration)
- [License](#license)

## Requirements

- **Terraform:** Version 0.12 or later is recommended.
- **AWS Account:** Ensure you have an active AWS account.
- **AWS CLI:** Installed and configured with appropriate IAM credentials.
- **Key Pair:** An existing AWS EC2 key pair (e.g., `Web01-key`) for SSH access.
- **Optional Tools:**
  - [Git](https://git-scm.com/) for version control.
  - [Ansible](https://www.ansible.com/) if using user data for post-deployment configuration.
  - [AWS Marketplace Subscription](https://aws.amazon.com/marketplace/) if using an AMI that requires it.

## Setup Instructions

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-username/InfrastructureCode.git
   cd InfrastructureCode
Configure AWS Credentials:

Ensure your AWS credentials are set up via one of the following methods:

Using the AWS CLI:

bash
Copy
Edit
aws configure
Provide your Access Key ID, Secret Access Key, and default region (e.g., us-east-1).

Using Environment Variables:

bash
Copy
Edit
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_DEFAULT_REGION="us-east-1"
Configure Terraform Variables:

Create a terraform.tfvars file or provide variable values interactively. Example content for terraform.tfvars:

hcl
Copy
Edit
aws_access_key = "your-access-key-id"
aws_secret_key = "your-secret-access-key"
Initialize Terraform:

Run the following command to initialize Terraform and download required providers:

bash
Copy
Edit
terraform init -upgrade
Review the Execution Plan:

Preview the changes before applying:

bash
Copy
Edit
terraform plan
Deploy the Infrastructure:

Apply the configuration to create the resources:

bash
Copy
Edit
terraform apply -auto-approve
Infrastructure Description
This infrastructure includes:

VPC (aws_vpc.custom_vpc):
A Virtual Private Cloud with a CIDR block of 10.0.0.0/16 to host all resources.

Subnet (aws_subnet.public_subnet):
A public subnet within the VPC (e.g., 10.0.2.0/24), created in a valid Availability Zone (e.g., us-east-1a).

Internet Gateway (aws_internet_gateway.ig_custom):
Provides a gateway for public internet access.

Route Table (aws_route_table.rt_custom_internet) and Association:
A route table with a default route to the Internet Gateway, and its association with the public subnet.

Security Group (aws_security_group.sg_custom):
Manages inbound/outbound traffic, allowing access (e.g., TCP port 80 and 8080) to the deployed instance.

EC2 Instance (aws_instance.ec2-worker1):
A t2.micro instance launched with a specified AMI. It is associated with the public subnet and security group, and uses a key pair (e.g., Web01-key) for SSH access.
The instance is configured to execute user data that installs necessary software (like Ansible and Git), clones a repository, and runs an Ansible playbook.

Deployment Process
Preparation:
Configure your AWS credentials and update your Terraform variables.

Terraform Initialization:
Run terraform init to set up the backend and providers.

Planning:
Use terraform plan to review the infrastructure changes.

Applying Changes:
Run terraform apply -auto-approve (or without the flag for interactive approval) to provision the infrastructure.

Post-deployment:

Verify the resources in the AWS Console.
Use the output (instance_public_ip) to access the EC2 instance.
Confirm that the EC2 instance has executed its user data script and is configured correctly.
Environment Variables and Configuration
AWS Credentials:

AWS_ACCESS_KEY_ID: Your AWS access key.
AWS_SECRET_ACCESS_KEY: Your AWS secret key.
AWS_DEFAULT_REGION: The region to deploy resources (e.g., us-east-1).
Terraform Variables:

aws_access_key: Provided via terraform.tfvars or command-line.
aws_secret_key: Provided via terraform.tfvars or command-line.
Key Pair:
Ensure that the key pair referenced (e.g., Web01-key) exists in the AWS region specified.

License
This repository is licensed under the MIT License. See the LICENSE file for details.

yaml
Copy
Edit

---

You can adjust the content as needed for your specific setup or preferences. Save this text as `README.md` in the root of your repository.
