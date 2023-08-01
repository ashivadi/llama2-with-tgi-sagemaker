# llama2-with-tgi-sagemaker
Helper to build the TGI image that will work with sagemaker and llama2-70b

First build the custom TGI image for sagemaker. Do this build process on an instance with at least 256gb memory, eg. r6i.12xlarge or m6a.16xlarge
```
git clone https://github.com/ashivadi/llama2-with-tgi-sagemaker.git
cd llama2-with-tgi-sagemaker
chmod +x ./build.sh
./build.sh
```

Next, push the image to ECR - this will be later pulled by the sagemaker instances

```
reponame='<Enter Repo name for ECR here>' #'sm-tgi093'
versiontag='1.0'
localimage='sm-tgi093' # this is the local image created from ./build.sh. Run docker image ls to get the name or hash
regionname='us-east-2' # or replace with your region
account='<Enter Account ID here>'
```

```
chmod +x ./push.sh
# Usage: $0 <ecr-repo-name> <version-tag> <localimage> <region> <account>"
./push.sh $reponame $versiontag $localimage $regionname $account
```