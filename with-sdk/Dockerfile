FROM mlukman/gitlab-ci-android:latest
MAINTAINER Muhammad Lukman Nasaruddin <anatilmizun@gmail.com>

ENV ANDROID_PLATFORM "android-22"
ENV ANDROID_BUILD_TOOLS "27.0.3"

RUN install-sdk \
	"platform-tools" \
	"platforms;${ANDROID_PLATFORM}" \
	"build-tools;${ANDROID_BUILD_TOOLS}" \
	"extras;android;m2repository" \
	"extras;google;m2repository" \
	"extras;google;google_play_services"
