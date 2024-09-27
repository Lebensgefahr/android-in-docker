FROM openjdk:18-jdk-slim

ARG ANDROID_SDK_ROOT
ARG EMULATOR_NAME
ARG EMULATOR_DEVICE
ARG EMULATOR_PACKAGE
ARG XAUTH
ARG ANDROID_CMD
ARG ANDROID_SDK_PACKAGES
ARG DISPLAY


ENV DEBIAN_FRONTEND noninteractive

WORKDIR /

COPY xauth .

RUN apt update && \
    apt install -y wget unzip libxi6 \
        libdrm-dev libxkbcommon-dev libgbm-dev \
        libasound-dev libnss3 libxcursor1 xvfb \
        libpulse-dev libxshmfence-dev xauth \
        libdbus-glib-1-2 && \
        apt-get autoremove --purge -y && \
        apt-get clean && \
        rm -Rf /tmp/* && rm -Rf /var/lib/apt/lists/*


#==============================
# Set JAVA_HOME - SDK
#==============================
ENV XAUTH=$XAUTH
ENV DISPLAY=$DISPLAY
ENV ANDROID_CMD=$ANDROID_CMD
ENV EMULATOR_NAME=$EMULATOR_NAME
ENV EMULATOR_DEVICE=$EMULATOR_DEVICE
ENV EMULATOR_PACKAGE=$EMULATOR_PACKAGE
ENV ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT
ENV ANDROID_SDK_PACKAGES=$ANDROID_SDK_PACKAGES
ENV PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS}"


COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

#=======================
# framework entry point
#=======================
CMD [ "/bin/bash" ]
