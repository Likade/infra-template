#!/bin/bash

echo "Eslint checks"

current_tag=$(git tag | tail -1 | head -n1)

if [ "$current_tag" == {rc-0.0.[1-9], rc-0.0.[1-9][1-9], rc-0.0.[1-9][1-9][1-9]}  ]
then
    echo "this is true!!!!!!"
else
    echo "this is false((("
fi

npm run build
exit $?