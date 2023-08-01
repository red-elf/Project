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
PROGRAM_VSCODE="code"
SCRIPT_INSTALL_VSCODE="$HERE/Toolkit/Utils/VSCode/install.sh"
SCRIPT_GET_PROGRAM="$HERE/Toolkit/Utils/Sys/Programs/get_program.sh"
VSCODE_INSTALLATION_PARAMS="$HERE/Recipes/vscode_installation_params.sh"

if ! test -e "$SCRIPT_GET_PROGRAM"; then

  echo "ERROR: Script not found, $SCRIPT_GET_PROGRAM"
  exit 1
fi

if ! sh "$SCRIPT_GET_PROGRAM" "$PROGAM"; then

  if [ "$PROGRAM" = "$PROGRAM_VSCODE" ]; then

    echo "ERROR: VSCode is not availble to open the project '$PROJECT', we are going to install it if possible"

    if test -e "$SCRIPT_INSTALL_VSCODE"; then

      if sh "$SCRIPT_INSTALL_VSCODE" "$VSCODE_INSTALLATION_PARAMS"; then

        echo "VSCode has been installed with success"

      else

        echo "ERROR: Failed to install VSCode"
        exit 1
      fi

    else

      echo "ERROR: VSCode installation script not found '$SCRIPT_INSTALL_VSCODE'"
      exit 1
    fi

  else

    echo "ERROR: $PROGAM is not availble to open the project '$PROJECT'"
    exit 1
  fi

fi

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
