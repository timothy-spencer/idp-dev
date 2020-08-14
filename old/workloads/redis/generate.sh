#!/bin/sh

helm template --name-template=redis bitnami/redis -f redis-values.yml > redis.yml

