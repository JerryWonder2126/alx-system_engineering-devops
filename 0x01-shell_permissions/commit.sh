#!/bin/bash

chmod u+x $2

git add .
git commit -m "$1"
git push
#echo "$1"
