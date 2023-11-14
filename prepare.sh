#!/bin/bash

if [ -z "$SUBMODULES_HOME" ]; then

  echo "ERROR: The SUBMODULES_HOME is not defined"
  exit 1
fi

if [ -z "$1" ]; then

  echo "ERROR: Project path parameter not ptovided"
  exit 1
fi

PATH_PROJECT="$1"

if ! test -e "$PATH_PROJECT"; then

  echo "ERROR: Project at path does not exist '$PATH_PROJECT'"
  exit 1
fi

echo "Preparing project at: '$PATH_PROJECT'"