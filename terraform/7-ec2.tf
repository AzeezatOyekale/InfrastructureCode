
resource "aws_instance" "ec2-worker1" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [ aws_security_group.sg_custom.id ]
    key_name = "Web01-key"

    user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install -y ansible git

        # Clone the Ansible playbook from GitHub
        git clone https://github.com/AzeezatOyekale/InfrastructureCode.git /home/ubuntu/InfrastructureCode

        # Run the Ansible playbook
        cd /home/ubuntu/InfrastructureCode/ansible
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
