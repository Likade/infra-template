#!/bin/bash

echo "Release creation"

comment=$1

current_tag=$(git tag | tail -1 | head -n1)
previous_tag=$(git tag | tail -2 | head -n1)

author=$(git show ${current_tag} | grep Author: | head -1)
date=$(git show ${current_tag}| grep Date: | head -1)
changeLog=`git log "${previous_tag}"..${current_tag} --pretty=format:"\n* %h -- %an -- %s;" | tr -s "\n" " "`
description="ответственный за релиз ${author}\n коммиты, попавшие в релиз:\n ${changeLog} \n ${comment}"

code=$(curl -w "%{http_code}\\n" \
-d '{"summary": "'"Релиз ${current_tag} - ${date}"'","description": "'"${description}"'"}' \
-H "Content-Type: application/json"  \
-H "Authorization: OAuth ${OAuth}" \
-H "X-Org-ID: ${OrgId}" \
-X PATCH https://api.tracker.yandex.net/v2/issues/HOMEWORKSHRI-183 \ 
-s -o /dev/null)

if [ "$code" = 201 ];
  then echo "Task created successfully!"
  exit 0
fi

if [ "$code" = 409 ]
  then echo "Task already exists!"
  else echo "Some problems"
  exit $code
fi

exit 0
