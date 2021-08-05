FROM openjdk:8-jdk

LABEL maintainer="kuuga"
    
ENV ANDROID_COMPILE_SDK "30"
ENV ANDROID_BUILD_TOOLS "30.0.2"
ENV ANDROID_SDK_TOOLS  "7583922"
ENV ANDROID_HOME $PWD/sdk
ENV ANDROID_SDK_ROOT $ANDROID_HOME/cmdline-tools/latest/
ENV PATH $PATH:$PWD/android_sdk/platform-tools/

RUN apt-get --quiet update --yes && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip && unzip -d sdk android-sdk.zip

RUN mkdir -p $ANDROID_SDK_ROOT

RUN echo y | $ANDROID_HOME/cmdline-tools/bin/sdkmanager "--sdk_root=$ANDROID_SDK_ROOT platforms;android-$ANDROID_COMPILE_SDK" >/dev/null
RUN echo y | $ANDROID_HOME/cmdline-tools/bin/sdkmanager "--sdk_root=$ANDROID_SDK_ROOT platform-tools" >/dev/null
RUN echo y | $ANDROID_HOME/cmdline-tools/bin/sdkmanager "--sdk_root=$ANDROID_SDK_ROOT build-tools;$ANDROID_BUILD_TOOLS" >/dev/null

RUN yes | $ANDROID_HOME/cmdline-tools/bin/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --licenses

RUN wget --quiet --output-document=/usr/local/bin/firebase https://firebase.tools/bin/linux/latest
RUN chmod +x /usr/local/bin/firebase

