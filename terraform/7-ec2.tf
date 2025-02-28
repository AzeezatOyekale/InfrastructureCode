
resource "aws_instance" "ec2-worker1" {
    ami = "ami-091f18e98bc129c4e"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [ aws_security_group.sg_custom.id ]
    key_name = "miseuwest2ipalacaprover"

    user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install -y ansible git

        # Clone the Ansible playbook from GitHub
        git clone https://github.com/Incrisz/Terraform-ansible-iac-HNG.git /home/ubuntu/Terraform-ansible-iac-HNG

        # Run the Ansible playbook
        cd /home/ubuntu/Terraform-ansible-iac-HNG/ansible
        ansible-playbook playbook.yml
    EOF

    # Tag the instance as "ec2-worker1" to differentiate it from other instances.
    tags = {
        "Name" = "ec2-worker1"
    }
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2-worker1.public_ip
}
