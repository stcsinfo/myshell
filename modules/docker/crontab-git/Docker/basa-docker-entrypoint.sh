#!/bin/sh
git config --global user.name $USER
git config --global user.email $EMAIL
git clone -b $GITLAB_PROJECT_DEVELOP_BRANCH --single-branch "https://$USER:$GITLAB_TOKEN@$GITLAB_PROJECT" rundeck-scripts-$GITLAB_PROJECT_DEVELOP_BRANCH
git clone -b $GITLAB_PROJECT_RELEASE_BRANCH --single-branch "https://$USER:$GITLAB_TOKEN@$GITLAB_PROJECT" rundeck-scripts-$GITLAB_PROJECT_RELEASE_BRANCH
crond -f -d 8