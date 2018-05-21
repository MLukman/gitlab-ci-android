# gitlab-ci-android
This Docker image contains the Android SDK and most common packages necessary for building Android apps in a CI tool like GitLab CI. Make sure your CI environment's caching works as expected, this greatly improves the build time, especially if you use multiple build jobs.

A `.gitlab-ci.yml` with caching of your project's dependencies would look like this (if your android platform version is 25):

```
image: mlukman/gitlab-ci-android

stages:
- build

before_script:
- install-sdk "platforms;android-25"

cache:
  key: ${CI_PROJECT_ID}
  paths:
  - .gradle/

build:
  stage: build
  script:
  - gradlew assembleDebug
  artifacts:
    paths:
    - app/build/outputs/apk/app-debug.apk
```

Or if you want to can use the following images and you can remove the `install-apk` command:

 - mlukman/gitlab-ci-android:android-17
 - mlukman/gitlab-ci-android:android-22
 - mlukman/gitlab-ci-android:android-24
 - mlukman/gitlab-ci-android:android-26
 