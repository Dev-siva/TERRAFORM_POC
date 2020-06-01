provider "aws" {} 
resource "aws_instance" "batch35" {
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
}

output "instance_ip_addr" {
  value = aws_instance.batch35.private_ip
}

resource "local_file" "foo" {
    content     = "${aws_instance.batch35.private_ip}"
    filename = "/tmp/hosts"
}