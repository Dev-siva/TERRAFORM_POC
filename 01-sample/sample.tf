provider "aws" {} 
resource "aws_instance" "batch34" {
  ami                    = "ami-0142dd089e0179d85"
  instance_type          = "t2.micro"
  subnet_id              =  "subnet-1c62f850"
  key_name               = "debopsb33"
  vpc_security_group_ids = [ "sg-03af617183681287f" ]  
  
  tags = {
    Name = "CloudCareers"
    Env = "Test"
    App = "RegApp"
    IncNo = "apb123"
  }  
 
 provisioner "file" {

  connection {
    type     = "ssh"
    user     = "centos"
    private_key = file("/home/centos/.ssh/id_rsa")
    host     = self.public_ip
     } 

    source      = "/home/centos/.ssh/id_rsa"
    destination = "/home/centos/.ssh/id_rsa"    
  }


 
 connection {
    type     = "ssh"
    user     = "centos"
    private_key = file("/home/centos/.ssh/id_rsa")
    host     = self.public_ip
  }
  
provisioner "remote-exec" {
    inline = [
         "sudo yum install ansible git -y",
         "echo -e 'Host * \n\tStrictHostKeyChecking no' > /home/centos/.ssh/config",
         "chmod 600 /home/centos/.ssh/id_rsa  /home/centos/.ssh/config",
         "ansible-pull -U git@gitlab.com:devops-batch34/ansible.git stack-pull.yaml"
    ]
  } 
}
