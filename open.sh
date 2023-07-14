#!/bin/bash

if [ -z "$1" ]; then

  echo "ERROR: Tool parameter not ptovided"
  exit 1
fi

if [ -z "$2" ]; then

  echo "ERROR: Project parameter not ptovided"
  exit 1
fi

PROGAM="$1"
PROJECT="$2"
HERE="$(dirname -- "$0")"
SCRIPT_GET_PROGRAM="$HERE/../Sys/Programs/get_program.sh"

if ! test -e "$SCRIPT_GET_PROGRAM"; then

  echo "ERROR: Script not found, $SCRIPT_GET_PROGRAM"
  exit 1
fi

if sh "$SCRIPT_GET_PROGRAM" "$PROGAM"; then

  "$PROGAM" "$PROJECT"

else
  
  echo "ERROR: $PROGAM is not availble to open the project '$PROJECT'"
  exit 1
fi
