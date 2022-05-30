#!/bin/bash
sed "s/tagVersion/$1/g" deployment.yml > sample-web-deployment.yml
