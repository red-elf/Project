#!/bin/bash

if [ -z "$1" ]; then

  echo "ERROR: Tool parameter not ptovided"
  exit 1
fi

if [ -z "$2" ]; then

  echo "ERROR: Project parameter not ptovided"
  exit 1
fi

PROGRAM="$1"
PROJECT="$2"
HERE="$(pwd)"
PROGRAM_VSCODE="code"
DIR_HOME=$(eval echo ~"$USER")
FILE_ZSH_RC="$DIR_HOME/.zshrc"
FILE_BASH_RC="$DIR_HOME/.bashrc"

FILE_RC=""
    
if test -e "$FILE_ZSH_RC"; then

  FILE_RC="$FILE_ZSH_RC"

else

    if test -e "$FILE_BASH_RC"; then

      FILE_RC="$FILE_BASH_RC"

    else

      echo "ERROR: No '$FILE_ZSH_RC' or '$FILE_BASH_RC' found on the system"
      exit 1
    fi
fi

# shellcheck disable=SC1090
. "$FILE_RC" >/dev/null 2>&1

if [ -z "$SUBMODULES_HOME" ]; then

  echo "ERROR: The SUBMODULES_HOME is not defined"
  exit 1
fi

DIR_TOOLKIT="$SUBMODULES_HOME/Software-Toolkit"

if ! test -e "$DIR_TOOLKIT"; then

  echo "ERROR: Toolkit directory not found '$DIR_TOOLKIT'"
  exit 1
fi

SCRIPT_INSTALL_VSCODE="$DIR_TOOLKIT/Utils/VSCode/install.sh"
SCRIPT_GET_PROGRAM="$DIR_TOOLKIT/Utils/Sys/Programs/get_program.sh"

VSCODE_INSTALLATION_PARAMS="$HERE/Recipes/vscode_installation_parameters.sh"

if ! test -e "$SCRIPT_GET_PROGRAM"; then

  echo "ERROR: Script not found, $SCRIPT_GET_PROGRAM"
  exit 1
fi

if ! test -e "$SCRIPT_INSTALL_VSCODE"; then

  echo "ERROR: VSCode installation script not found '$SCRIPT_INSTALL_VSCODE'"
  exit 1
fi

if ! test -e "$VSCODE_INSTALLATION_PARAMS"; then

  echo "ERROR: VSCode installation parameters not found at '$VSCODE_INSTALLATION_PARAMS'"
  exit 1
fi

if ! sh "$SCRIPT_GET_PROGRAM" "$PROGRAM"; then

  if [ "$PROGRAM" = "$PROGRAM_VSCODE" ]; then

    echo "WARNING: VSCode is not availble to open the project '$PROJECT', we are going to install it if possible"

    if sh "$SCRIPT_INSTALL_VSCODE" "$VSCODE_INSTALLATION_PARAMS"; then

        echo "VSCode has been installed with success"

      else

        echo "ERROR: Failed to install VSCode"
        exit 1
      fi

  else

    echo "ERROR: $PROGRAM is not availble to open the project '$PROJECT'"
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

"$PROGRAM" "$PROJECT"
