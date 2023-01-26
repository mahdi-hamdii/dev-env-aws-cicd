locals {
  ssh_user = "ubuntu"
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_inbound_ssh_outbound_all"
  }
}

data "aws_key_pair" "web_server_ssh_key" {
  key_name           = "terraz"
  include_public_key = true

  filter {
    name   = "tag:name"
    values = ["github"]
  }
}

resource "aws_instance" "web_server" {
  ami             = "ami-00874d747dde814fa"
  instance_type   = "t2.micro"
  key_name        = data.aws_key_pair.web_server_ssh_key.key_name
  security_groups = [aws_security_group.allow_ssh.name]
  tags = {
    Name = "DevEnvironment"
  }
}
resource "local_file" "ansible_inventory" {
  depends_on = [
    aws_instance.web_server
  ]
  content = templatefile("inventory.ini",
    {
      user      = local.ssh_user
      public_ip = aws_instance.web_server.public_ip
    }
  )
  filename = "inventory-result.ini"
}

resource "null_resource" "example" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.web_server.public_ip
    }


    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "ansible-playbook --extra-vars=\"aws_access_key=${var.aws_access_key}\" --extra-vars=\"aws_secret_key=${var.aws_secret_key}\" -i inventory-result.ini --private-key ${var.private_key_path} init-aws-docker.yml"
  }
}
