# llama2-70b-with-tgi-sagemaker
Helper to build the TGI image that will work with sagemaker and [llama2-70b](https://huggingface.co/meta-llama/Llama-2-70b-chat-hf). Note you need your own [Huggingface API key](https://huggingface.co/settings/tokens) and must accept [Llama2 EULA](https://ai.meta.com/resources/models-and-libraries/llama-downloads/).

### Build custom TGI image for Sagemaker. 
First build the custom TGI image for sagemaker. Do this build process on an instance with at least 256gb memory, eg. r6i.12xlarge or m6a.16xlarge
```
git clone https://github.com/ashivadi/llama2-with-tgi-sagemaker.git
cd llama2-with-tgi-sagemaker
chmod +x ./build.sh
./build.sh
```

### Push custom image to ECR
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
### Deploy and Test
Next, run the notebook [huggingface-large-model-inference-llama2-TGI-customImage.ipynb](https://github.com/ashivadi/llama2-with-tgi-sagemaker/blob/main/huggingface-large-model-inference-llama2-TGI-customImage.ipynb) to deploy and test on Sagemaker

#### Credits
1. Wenju Zhang via. https://tropical-dresser-bff.notion.site/TGI-1-0-0-docker-image-build-guide-baa11386695a4988ba7e1bb0ae3b4a7f
2. Thanks to [philschmid](https://github.com/awslabs/llm-hosting-container/pull/19) and [xyang16](https://github.com/xyang16)