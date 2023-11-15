#!/bin/bash

if [ -z "$SUBMODULES_HOME" ]; then

  echo "ERROR: The SUBMODULES_HOME is not defined"
  exit 1
fi

if [ -z "$1" ]; then

  echo "ERROR: Project path parameter not provided"
  exit 1
fi

PATH_PROJECT="$1"

if ! test -e "$PATH_PROJECT"; then

  echo "ERROR: Project at path does not exist '$PATH_PROJECT'"
  exit 1
fi

echo "Preparing project at: '$PATH_PROJECT'"

FILE_SYNC="sync"
FILE_CLONE="clone"
FILE_PULL_ALL="pull_all"
FILE_PUSH_ALL="push_all"

SCRIPT_LINK="$SUBMODULES_HOME/Software-Toolkit/Utils/Sys/Filesystem/link.sh"

if ! test -e "$SCRIPT_LINK"; then

  echo "ERROR: Script not found '$SCRIPT_LINK'"
  exit 1
fi

# shellcheck disable=SC1090
. "$SCRIPT_LINK"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_SYNC" "$PATH_PROJECT/$FILE_SYNC"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_CLONE" "$PATH_PROJECT/$FILE_CLONE"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_PULL_ALL" "$PATH_PROJECT/$FILE_PULL_ALL"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_PUSH_ALL" "$PATH_PROJECT/$FILE_PUSH_ALL"