resource "aws_instance" "EC2" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    count = 2   
    key_name = "Pathak-SahaB"
    vpc_security_group_ids = [aws_security_group.Security-Group.id]
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install openjdk-1-jdk
                sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
                wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz -P /tmp
                wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v${VERSION}/bin/apache-tomcat-${VERSION}.tar.gz -P /tmp
                sudo tar -xf /tmp/apache-tomcat-${VERSION}.tar.gz -C /opt/tomcat/
                sudo ln -s /opt/tomcat/apache-tomcat-${VERSION} /opt/tomcat/latest
                sudo chown -R tomcat: /opt/tomcat
    EOF
                
}