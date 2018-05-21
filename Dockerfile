FROM ubuntu:16.04
MAINTAINER Muhammad Lukman Nasaruddin <anatilmizun@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
# version 26.0.1
ENV ANDROID_SDK_TOOLS_VERSION "3859397"
ENV ANDROID_BUILD_TOOLS_VERSION "27.0.3"
ENV ANDROID_HOME "/sdk"
ENV GRADLE_VERSION 4.7
ENV GRADLE_SDK_URL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME ${ANDROID_HOME}/gradle-${GRADLE_VERSION}
ENV PATH "${GRADLE_HOME}/bin:$PATH:${ANDROID_HOME}/tools/bin"

RUN apt-get -qq update \
    && apt-get install -qqy --no-install-recommends \
      curl \
      html2text \
      openjdk-8-jdk \
      libc6-i386 \
      lib32stdc++6 \
      lib32gcc1 \
      lib32ncurses5 \
      lib32z1 \
      unzip \
      wget \
      aria2\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    ; rm -f /etc/ssl/certs/java/cacerts \
    ; /var/lib/dpkg/info/ca-certificates-java.postinst configure

ADD install-sdk /usr/bin/

RUN aria2c -x5 -k1M http://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip -o /tools.zip \
    && unzip /tools.zip -d ${ANDROID_HOME} \
    && rm -v /tools.zip \
    && mkdir -p $ANDROID_HOME/licenses/ \
    && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license \
    && echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_HOME/licenses/android-sdk-preview-license \
    && chmod +x /usr/bin/install-sdk
    
RUN /usr/bin/install-sdk "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"

RUN curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  \
	&& unzip gradle-${GRADLE_VERSION}-bin.zip -d ${ANDROID_HOME}  \
	&& rm -rf gradle-${GRADLE_VERSION}-bin.zip
