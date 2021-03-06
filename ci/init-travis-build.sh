#!/bin/bash

echo -e "Branch: ${TRAVIS_BRANCH}"
echo -e "************************************"
echo -e "Pull request branch: ${TRAVIS_PULL_REQUEST_BRANCH}"
echo -e "Pull Request: ${TRAVIS_PULL_REQUEST}"
echo -e "Pull Request SHA: ${TRAVIS_PULL_REQUEST_SHA}"
echo -e "************************************"
echo -e "Build directory: ${TRAVIS_BUILD_DIR}"
echo -e "Build id: ${TRAVIS_BUILD_ID}"
echo -e "Build type: ${TRAVIS_EVENT_TYPE}"
echo -e "Build number: ${TRAVIS_BUILD_NUMBER}"
echo -e "************************************"
echo -e "Job id: ${TRAVIS_JOB_ID}"
echo -e "Job number: ${TRAVIS_JOB_NUMBER}"
echo -e "************************************"
echo -e "Repo slug: ${TRAVIS_REPO_SLUG}"
echo -e "JAVA_HOME: ${JAVA_HOME}"
echo -e "OS name: ${TRAVIS_OS_NAME}"
echo -e "************************************"
echo -e "Commit: ${TRAVIS_COMMIT}"
echo -e "Commit Range: ${TRAVIS_COMMIT_RANGE}"
echo -e "Commit Message: ${TRAVIS_COMMIT_MESSAGE}"
echo -e "************************************"
echo -e "User: ${USER}"
echo -e "User HOME directory: ${HOME}"
echo -e "Secure environment variables: ${TRAVIS_SECURE_ENV_VARS}"
echo -e "************************************"

if [ "$TRAVIS_SECURE_ENV_VARS" == "false" ]
then
  echo -e "Secure environment variables are NOT available...\n"
else
  echo -e "Secure environment variables are available...\n"
  #echo -e "GH_TOKEN -> ${GH_TOKEN}"
fi

if [ "$TRAVIS_PULL_REQUEST" != "false" ] && [ "$PUBLISH_SNAPSHOTS" == "true" ]; then
    echo -e "Skipping build since this is a pull request and we are not publishing snapshots.\n"
    exit 0
fi

echo -e "Configuring Gradle wrapper...\n"
chmod -R 777 ./gradlew

echo -e "Installing NPM...\n"
#mkdir ~/.npm-global
#export NPM_CONFIG_PREFIX=~/.npm-global
#echo "NPM config environment variable: $NPM_CONFIG_PREFIX"
./gradlew npmInstall --stacktrace -q
echo "Rebuilding using node-sass"
npm rebuild node-sass

echo -e "Configured build environment\n"
