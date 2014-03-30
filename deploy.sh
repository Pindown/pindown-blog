#!/bin/bash
cd $DEPLOY_PROJECT_PATH/blog
source env/bin/activate
make html
