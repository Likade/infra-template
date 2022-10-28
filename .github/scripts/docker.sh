#!/bin/bash

echo "Run docker"

current_tag=$(git tag | tail -1 | head -n1)

docker build . -f Dockerfile -t ${current_tag}

if [ $? -ne 0 ]
then
    result="Creation docker faild"
    echo "$result"
    bash ./.github/scripts/release.sh "$result"
    exit $?
else
    result="Created docker version: ${current_tag}"
    echo "$result"
    bash ./.github/scripts/release.sh "$result"
    exit 0
fi