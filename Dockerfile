FROM ubuntu:20.04
MAINTAINER Muhammad Lukman Nasaruddin <anatilmizun@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_CMDLINE_TOOLS_VERSION "6858069"
ENV ANDROID_BUILD_TOOLS_VERSION "30.0.3"
ENV ANDROID_HOME "/sdk"
ENV GRADLE_VERSION 6.2
ENV GRADLE_SDK_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME ${ANDROID_HOME}/gradle-${GRADLE_VERSION}
ENV PATH "${GRADLE_HOME}/bin:$PATH:${ANDROID_HOME}/cmdline-tools/bin"

RUN apt-get -qq update \
    && apt-get install -qqy --no-install-recommends \
      curl \
      html2text \
      openjdk-8-jdk \
      libc6-i386 \
      lib32stdc++6 \
      lib32gcc1 \
      lib32ncurses5-dev \
      lib32z1 \
      unzip \
      wget \
      aria2\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -f /etc/ssl/certs/java/cacerts \
    && /var/lib/dpkg/info/ca-certificates-java.postinst configure

RUN aria2c -x5 -k1M https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS_VERSION}_latest.zip -o /tools.zip \
    && unzip /tools.zip -d ${ANDROID_HOME} \
    && rm -v /tools.zip

ADD install-sdk /usr/bin/
             
RUN chmod +x /usr/bin/install-sdk \
    && /usr/bin/install-sdk "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"

RUN curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
	&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${ANDROID_HOME}  \
	&& rm -rf gradle-${GRADLE_VERSION}-bin.zip
