$profilename="default"
echo "AWS Profile name is: $profilename"
# Get the region defined in the current configuration (default to us-east-1 if none defined)
$region=$(aws configure get region --profile $profilename)
#$region=${region:-us-east-1}
echo "AWS Profile region is: $region"
# Get the account number associated with the current IAM credentials
$account=$(aws sts get-caller-identity --query Account --output text --profile $profilename)

# Get the login command from ECR and execute it directly
#$(aws ecr get-login --region ${region} --no-include-email --profile $profilename)
#aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com
$(aws ecr get-login-password --region ${region} | docker login --username  AWS --password-stdin "${account}.dkr.ecr.${region}.amazonaws.com")

# This script shows how to build the Docker image and push it to ECR to be ready for use by SageMaker.
# The argument to this script is the image name. This will be used as the image on the local
# machine and combined with the account and region to form the repository name for ECR.
$nginx_name = "raznginx_new"
$fullname_nginx="${account}.dkr.ecr.${region}.amazonaws.com/${nginx_name}:latest"
echo "ECR image fullname is: $fullname_nginx"

# If the repository doesn't exist in ECR, create it.

$x = aws ecr describe-repositories --repository-names "${nginx_name}" --profile $profilename
echo $x

if ($x -ne 0)
{
     aws ecr create-repository --repository-name "${nginx_name}" --profile $profilename
}

# Build the docker image locally with the image name and then push it to ECR with the full name.
docker build  -t ${nginx_name} ./nginx --build-arg REGION=${region}
docker tag ${nginx_name} ${fullname_nginx}

docker push ${fullname_nginx}



$orthanc_name = "razorthanc_new"
$fullname_ortanc="${account}.dkr.ecr.${region}.amazonaws.com/${orthanc_name}:latest"
echo "ECR image fullname is: $fullname_nginx"

$x = aws ecr describe-repositories --repository-names "${orthanc_name}" --profile $profilename
echo $x
if ($x -ne 0)
{
     aws ecr create-repository --repository-name "${orthanc_name}" --profile $profilename
}

# Build the docker image locally with the image name and then push it to ECR with the full name.
docker build  -t ${orthanc_name} ./orthanc --build-arg REGION=${region}
docker tag ${orthanc_name} ${fullname_ortanc}

docker push ${fullname_ortanc}


#docker context use "myecscontext"
#docker compose up
#docker context use "default"

