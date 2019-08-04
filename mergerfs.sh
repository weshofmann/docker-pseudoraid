#!/bin/sh

if [ ! -f /config/mergerfs.conf ]; then
  echo "No mergerfs.conf found.  This must be provided to configure mergerfs!"
  exit 1
fi

function join() {
  local IFS="$1"
  shift
  echo "$*"
}

source /config/mergerfs.conf

# Get sources from snapraid.conf
sources=$(grep "^data" /config/snapraid.conf | sed 's/data\s\+\S\+\s\+//')
if [ -n "x${MERGERFS_REL_PATH}" ]; then
  tmp=""
  for i in ${sources}; do
    if [ ! -d "$i/${MERGERFS_REL_PATH}" ]; then
      mkdir -p "$i/${MERGERFS_REL_PATH}"
      chmod a+rwx "$i/${MERGERFS_REL_PATH}"
    fi
    tmp="${tmp} $i/${MERGERFS_REL_PATH}"
  done
  sources="${tmp}"
fi

sources=$(join ":" ${sources})

if cat /proc/mounts | grep "${MERGERFS_MOUNT}.*fuse.mergerfs" 1>/dev/null 2>&1; then
  echo "* mergerfs ${MERGERFS_MOUNT} is already mounted, unmounting..."
  fusermount -u ${MERGERFS_MOUNT}
fi

if [ ! -d "${MERGERFS_MOUNT}" ]; then
  mkdir -p "${MERGERFS_MOUNT}"
  chmod a+rx "${MERGERFS_MOUNT}"
fi

echo "* mounting mergerfs: [ ${sources} ]"
echo "      to --> ${MERGERFS_MOUNT}"
mergerfs -o ${MERGERFS_OPTS} ${sources} ${MERGERFS_MOUNT}
