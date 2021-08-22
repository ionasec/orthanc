#orthanc for Docker
https://book.orthanc-server.com/users/docker.html

docker pull jodogne/orthanc-plugins

docker run -p 4242:4242 -p 8042:8042 --rm jodogne/orthanc-plugins

#The default username is orthanc and its password is orthanc

curl -u orthanc:orthanc http://localhost:8042/patients

https://aws.amazon.com/getting-started/hands-on/deploy-docker-containers/

https://aws.amazon.com/blogs/containers/deploy-applications-on-amazon-ecs-using-docker-compose/

http://ec2co-ecsel-16qd2ro7zfj6t-1881672113.us-east-1.elb.amazonaws.com:8042/


https://bitbucket.org/osimis/orthanc-setup-samples/src/master/
