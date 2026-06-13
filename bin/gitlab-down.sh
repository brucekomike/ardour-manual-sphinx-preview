#!/bin/bash
# tested on ubuntu
# download the latest artifact from a gitlab repo

# Configuration
GITLAB_URL="https://gitlab.com" #gitlab instance url
JOB_NAME="build_docs" #job name
NAME_SPACE="" # user name or group name
PROJECT_NAME="" # project name
BRANCH="main" #branch
TOKEN=""  #your access token

# Construct the full URL for downloading artifacts
DOCS_APPENDIX="/api/v4/projects/$NAME_SPACE%2F$PROJECT_NAME\
/jobs/artifacts/$BRANCH/download?job=$JOB_NAME"
FULL_URL="$GITLAB_URL$DOCS_APPENDIX"

# Execute the download function
curl -fsSL --header "PRIVATE-TOKEN: $TOKEN" $FULL_URL -o tmp.zip
if [ -f "tmp.zip" ]; then
  rm -rf html-docs.bak
  mv html-docs html-docs.bak
  unzip tmp.zip
fi
if [ -d "html-docs" ]; then
    rm tmp.zip
fi
