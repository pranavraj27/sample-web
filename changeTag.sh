#!/bin/bash
sed "s/tagVersion/$1/g" pods.yml > sample-web-pod.yml
