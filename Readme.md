**project: creating a ec2 instance on aws infrastructure using terraform**
first of all i need to create a vpc and then i need to create a subnet inside that vpc
after that i need to provide the inetrnet access to that subnet
later i will provision ec2 instance inside the subnet
deploy an nginx docker container on the ec2 instance
create a firewall security group roles to access nginx web app running on ec2 ssh and port 8080
after creating a vpc and subnet then compare your vpc route table with defualt route table of default vpc which is able to access the internet then based on that route table create a route table to allow traffic and internet access to ur vpc
first of all u need to create a internet a gateway to connect ur vpc to the internet and then u create a route table to route all the traffic coming from internet gateway
After creating a route table in a VPC, it must be associated with a subnet so that the subnet’s traffic follows the routes defined in that table.”
next we define the security group because we want to deploy our virtual server in vpc so needed port 22 to login and to run nginx container on it to access from browser needed port 8080