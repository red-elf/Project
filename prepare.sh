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

# TODO: Move to the Software Toolkit utils
#
LINK_FILE_TO_PROJECT() {

  if [ -z "$1" ]; then

    echo "ERROR: Link what path parameter not provided"
    exit 1
  fi

  if [ -z "$2" ]; then

    echo "ERROR: Link to path parameter not provided"
    exit 1
  fi

  LINK_WHAT="$1"
  LINK_TO="$2"

  if ! test -e "$LINK_WHAT"; then

    echo "ERROR: Source does not exist '$LINK_WHAT'"
    exit 1
  fi

  if test -e "$LINK_TO"; then

    if ! rm -f "$LINK_TO"; then

      echo "ERROR: Link to was ot cleaned up '$LINK_TO'"
      exit 1
    fi
  fi

  if ln -s "$LINK_WHAT" "$LINK_TO"; then

    echo "Linked: $LINK_WHAT -> $LINK_TO"
  fi
}

FILE_PULL_ALL="pull_all"

LINK_FILE_TO_PROJECT "$SUBMODULES_HOME/$FILE_PULL_ALL" "$PATH_PROJECT/$FILE_PULL_ALL"