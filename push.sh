#!/usr/bin/env bash

# This script shows how to push an already built the Docker image and push it to ECR to be ready for use
# by SageMaker. Modified from this starting point: https://github.com/aws/amazon-sagemaker-examples/blob/main/inference/torchserve/mme-gpu/workspace/docker/build_and_push.sh

# The argument to this script is the image name. This will be used as the image on the local
# machine and combined with the account and region to form the repository name for ECR.
reponame=$1
versiontag=$2
localimage=$3
regionname=$4
account=$5

if [ "$reponame" == "" ] || [ "$versiontag" == "" ]  || [ "$localimage" == "" ] || [ "$regionname" == "" ] || [ "$account" == "" ]
then
    echo "Usage: $0 <ecr-repo-name> <version-tag> <localimage> <region> <account>"
    exit 1
fi

if [ $? -ne 0 ]
then
    exit 255
fi

fullname="${account}.dkr.ecr.${regionname}.amazonaws.com/${reponame}:${versiontag}"

# If the repository doesn't exist in ECR, create it.
aws ecr describe-repositories --repository-names "${reponame}" --region="${regionname}" > /dev/null 2>&1

if [ $? -ne 0 ]
then
    aws ecr create-repository --repository-name "${reponame}" --region="${regionname}" > /dev/null
fi

aws ecr get-login-password --region $regionname | docker login --username AWS --password-stdin ${account}.dkr.ecr."${regionname}".amazonaws.com

# Build the docker image locally with the image name and then push it to ECR
# with the full name.
# docker build  -t ${reponame} . --build-arg BASE_IMAGE=${localimage}

# assume you have run this below line already from the terminal at GenAI folder
# docker buildx build -t ${localimage} -f ~/GenAI/llm-hosting-container/huggingface/pytorch/tgi/docker/0.9.3/py3/cu118/Dockerfile.gpu .

docker tag ${localimage} ${fullname}

docker push ${fullname}
echo "${fullname}"
