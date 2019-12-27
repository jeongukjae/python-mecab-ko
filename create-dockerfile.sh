#!/bin/bash

while read line; do
    image=($line)
    echo "{\"base_image\":\"${image[0]}\"}" | jinja2 --format=json sources/template.Dockerfile > ${image[1]}.Dockerfile
done <sources/versions.txt
