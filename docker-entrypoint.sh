#!/bin/bash -x

echo "Running: $@"

if [[ ! -d "$ANDROID_SDK_ROOT/cmdline-tools" ]]; then
  wget https://dl.google.com/android/repository/${ANDROID_CMD} -P $ANDROID_SDK_ROOT && \
  unzip $ANDROID_SDK_ROOT/$ANDROID_CMD -d $ANDROID_SDK_ROOT  && \
  mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/tools && \
  cd $ANDROID_SDK_ROOT/cmdline-tools && \
  mv NOTICE.txt source.properties bin lib tools/  && \
  rm -f $ANDROID_SDK_ROOT/$ANDROID_CMD
fi

  yes | sdkmanager --licenses && \
  yes | sdkmanager --verbose --no_https ${ANDROID_SDK_PACKAGES} && \
  avdmanager --verbose create avd --name "${EMULATOR_NAME}" --device "${EMULATOR_DEVICE}" --package "${EMULATOR_PACKAGE}"

if [[ -f "$XAUTH" ]]; then
  xauth add $(cat "$XAUTH")
else
  echo "Create xauth file first"
  exit 1
fi

exec "$@"