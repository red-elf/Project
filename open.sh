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
HERE="$(pwd)"
SCRIPT_GET_PROGRAM="$HERE/Toolkit/Utils/Sys/Programs/get_program.sh"

if ! test -e "$SCRIPT_GET_PROGRAM"; then

  echo "ERROR: Script not found, $SCRIPT_GET_PROGRAM"
  exit 1
fi

if sh "$SCRIPT_GET_PROGRAM" "$PROGAM"; then

  SCRIPT_RECIPE_PRE_OPEN="$HERE/Recipes/project_pre_open.sh"

  if test -e "$SCRIPT_RECIPE_PRE_OPEN"; then

      if ! sh "$SCRIPT_RECIPE_PRE_OPEN"; then

          echo "ERROR: Recipe failed, $SCRIPT_RECIPE_PRE_OPEN"
          exit 1
      fi
  else

      echo "WARNING: No pre-opening recipe found, $SCRIPT_RECIPE_PRE_OPEN"
  fi

  "$PROGAM" "$PROJECT"

else
  
  echo "ERROR: $PROGAM is not availble to open the project '$PROJECT'"
  exit 1
fi
