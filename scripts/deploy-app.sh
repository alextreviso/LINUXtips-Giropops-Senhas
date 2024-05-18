#!/bin/bash

docker container run -d --name redis -p 6379:6379 redis:4 

REDIS_HOST=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis)

docker image build --no-cache -t alextreviso/linuxtips-giropops-senha:1.0 --build-arg REDIS_HOST=$REDIS_HOST .

docker container run -d -p 5000:5000 --name giropops-senhas alextreviso/linuxtips-giropops-senha:1.0