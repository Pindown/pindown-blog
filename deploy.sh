#!/bin/bash
cd $DEPLOY_PROJECT_PATH/blog
source env/bin/activate
git reset --hard
git pull origin master
make html
