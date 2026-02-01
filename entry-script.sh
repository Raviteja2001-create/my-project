
#!/bin/bash
set -xe

yum update -y
amazon-linux-extras install docker -y

systemctl enable docker
systemctl start docker

docker run -d -p 8080:80 nginx
