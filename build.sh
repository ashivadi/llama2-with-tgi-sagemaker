#!/usr/bin/env bash
# Run this on an instance with at least 256GB memory, like r6i.12xlarge.
# inspired from https://tropical-dresser-bff.notion.site/TGI-1-0-0-docker-image-build-guide-baa11386695a4988ba7e1bb0ae3b4a7f
# and this comment: https://github.com/awslabs/llm-hosting-container/pull/19#issuecomment-1659008970

mkdir GenAI
cd GenAI
git clone https://github.com/huggingface/text-generation-inference
cd text-generation-inference
git clone https://github.com/awslabs/llm-hosting-container


# Basically updaing the relative paths in the docker file so they point to the right folder in text-generation-inference
#cp ./llm-hosting-container/huggingface/pytorch/tgi/docker/0.9.3/py3/cu118/Dockerfile.gpu ./llm-hosting-container/huggingface/pytorch/tgi/docker/0.9.3/py3/cu118/Dockerfile.gpu.bak
#mv Dockerfile.gpu ./llm-hosting-container/huggingface/pytorch/tgi/docker/0.9.3/py3/cu118/Dockerfile.gpu

docker buildx build -t sm-tgi093 -f ./llm-hosting-container/huggingface/pytorch/tgi/docker/0.9.3/py3/cu118/Dockerfile.gpu .
