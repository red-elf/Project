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
SCRIPT_EXTEND_JSON="$DIR_TOOLKIT//Utils/Sys/JSON/merge_jsons.sh"
SCRIPT_GET_PROGRAM="$DIR_TOOLKIT/Utils/Sys/Programs/get_program.sh"
SCRIPT_GET_CODE_PATHS="$SUBMODULES_HOME/Software-Toolkit/Utils/VSCode/get_paths.sh"
SCRIPT_GET_PROGRAM="$SUBMODULES_HOME/Software-Toolkit/Utils/Sys/Programs/get_program.sh"

if ! test -e "$SCRIPT_GET_CODE_PATHS"; then

  echo "ERROR: Script not found '$SCRIPT_GET_CODE_PATHS'"
  exit 1
fi

if ! test -e "$SCRIPT_GET_CODE_PATHS"; then

  echo "ERROR: Script not found '$SCRIPT_GET_CODE_PATHS'"
  exit 1
fi

# shellcheck disable=SC1090
. "$SCRIPT_GET_CODE_PATHS"

VSCODE_INSTALLATION_PARAMS="$HERE/Recipes/VSCode/installation_parameters_vscode.sh"

if ! test -e "$SCRIPT_GET_PROGRAM"; then

  echo "ERROR: Script not found, $SCRIPT_GET_PROGRAM"
  exit 1
fi

if ! test -e "$SCRIPT_EXTEND_JSON"; then

  echo "ERROR: Script not found '$SCRIPT_EXTEND_JSON'"
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

if sh "$SCRIPT_GET_PROGRAM" "$PROGRAM" >/dev/null 2>&1; then

  if [ "$PROGRAM" = "$PROGRAM_VSCODE" ]; then

    echo "VSCode is installed on your system" && echo "Checking VSCode data version"

    CODE_HOME=$(which "$PROGRAM")
    
    if test -e "$CODE_HOME" && file "$CODE_HOME" | grep "executable" >/dev/null 2>&1; then

      CODE_HOME=$(dirname "${CODE_HOME}")

      if test -e "$CODE_HOME" && file "$CODE_HOME" | grep "directory" >/dev/null 2>&1; then

        VERSION_FILE="$CODE_HOME/data_version.txt"
        OBTAINED_DATA_VERSION=$(curl "http://$SHARES_SERVER:8081/data_version.txt")

        if test -e "$VERSION_FILE"; then

          CURRENT_VSCODE_VERSION=$(cat "$VERSION_FILE")

        else

          CURRENT_VSCODE_VERSION="Undefined"
        fi

        echo "Current VSCode data version: $CURRENT_VSCODE_VERSION"

        if [ -z "$SHARES_SERVER" ]; then

            echo "The 'SHARES_SERVER' is not defined"
            exit 1
        fi

        echo "Ontained VSCode data version: $OBTAINED_DATA_VERSION"

        # shellcheck disable=SC2002
        if ! echo "$OBTAINED_DATA_VERSION" | grep "404 Not Found" >/dev/null 2>&1; then

          echo "Comparing VSCode data versions"

          if [ "$CURRENT_VSCODE_VERSION" = "$OBTAINED_DATA_VERSION" ]; then

            echo "Data version is up to date: $CURRENT_VSCODE_VERSION"

          else

              echo "New VSCode data version is available: $OBTAINED_DATA_VERSION"
              
              echo "Ready to update? [y/n]"

              read -r answer

              if [ "$answer" != "${answer#[Yy]}" ] ;then 
                  
                  echo "Starting the update"

                  SCRIPT_INSTALL="$DIR_TOOLKIT/Utils/VSCode/install.sh" 
                  LOCAL_RECIPE="$HERE/Recipes/VSCode/installation_parameters_vscode.sh"

                  if test -e "$SCRIPT_INSTALL"; then

                    FINISH_SUCCESS() {

                      echo "Installation has been completed with success. Now you can open your project."
                      exit 0
                    }

                    FINISH_FAILURE() {
                      
                      echo "ERROR: Installation has failed"
                      exit 1
                    }

                    if test -e "$LOCAL_RECIPE"; then

                      if sh "$SCRIPT_INSTALL" "$LOCAL_RECIPE"; then

                        FINISH_SUCCESS

                      else

                        FINISH_FAILURE
                      fi

                    else

                      if sh "$SCRIPT_INSTALL"; then

                        FINISH_SUCCESS

                      else

                        FINISH_FAILURE
                      fi

                    fi

                  else

                    echo "ERROR: Installation script not found '$SCRIPT_INSTALL'"
                    exit 1
                  fi

              else
                  
                  echo "WARNING: Skipping the update"
              fi

          fi

        else

          echo "WARNING: No data caersion obtained"
        fi

      else

        echo "WARNING: No valid '$PROGRAM' home at '$CODE_HOME' (2)"
      fi

    else

      echo "WARNING: No valid '$PROGRAM' home at '$CODE_HOME' (1)"
    fi

  else

    echo "ERROR: $PROGRAM is not availble to open the project '$PROJECT' (1)"
    exit 1
  fi

else

  if [ "$PROGRAM" = "$PROGRAM_VSCODE" ]; then

    echo "WARNING: VSCode is not availble to open the project '$PROJECT', we are going to install it if possible"

    if sh "$SCRIPT_INSTALL_VSCODE" "$VSCODE_INSTALLATION_PARAMS"; then

        echo "VSCode has been installed with success"

      else

        echo "ERROR: Failed to install VSCode"
        exit 1
      fi

  else

    echo "ERROR: $PROGRAM is not availble to open the project '$PROJECT' (2)"
    exit 1
  fi
  
fi

if sh "$SCRIPT_GET_PROGRAM" "$PROGRAM" >/dev/null 2>&1; then

  if [ "$PROGRAM" = "$PROGRAM_VSCODE" ]; then

      SETTINGS_DIR="$HERE/.vscode"
    
      GET_VSCODE_PATHS

      if [ -z "$CODE_DIR" ]; then

          echo "ERROR: the 'CODE_DIR' variable is not set"
          exit 1
      fi

      if [ -z "$CODE_DATA_DIR" ]; then

          echo "ERROR: the 'CODE_DIR' variable is not set"
          exit 1
      fi

      SETTINGS_DIR_USER="$CODE_DATA_DIR/user-data/User"

      if test -e "$SETTINGS_DIR"; then

        echo "Settings directory: '$SETTINGS_DIR'"

      else

        if ! mkdir -p "$SETTINGS_DIR"; then

          echo "ERROR: Could not create directory '$SETTINGS_DIR'"
          exit 1
        fi
      fi

      SETTINGS_JSON="$SETTINGS_DIR/settings.json"
      SETTINGS_JSON_USER="$SETTINGS_DIR_USER/settings.json"

      if test -e "$SETTINGS_JSON"; then

        echo "Settings JSON: '$SETTINGS_JSON'"

      else

        if echo "{}" > "$SETTINGS_JSON"; then

          echo "Settings JSON has bee initialized at: '$SETTINGS_JSON'"

        else

          echo "ERROR: Could not initialize settings JSON at '$SETTINGS_JSON'"
          exit 1
        fi
      fi

      RECIPE_USER_DEFAULTS="$HERE/Recipes/VSCode/settings.user.json.sh"

      if test -e "$RECIPE_USER_DEFAULTS"; then

        # shellcheck disable=SC1090
        if sh "$SCRIPT_EXTEND_JSON" "$SETTINGS_JSON_USER" "$RECIPE_USER_DEFAULTS" "$SETTINGS_JSON_USER" >/dev/null 2>&1; then

          echo "VSCode settings have been configured (1)"

        else

          echo "ERROR: VSCode settings have not been configured (1)"
          exit 1
        fi
      fi

      SCRIPT_GET_SONAR_NAME="get_sonar_project_name.sh"
      SCRIPT_GET_SONAR_NAME_FULL="$SUBMODULES_HOME/Software-Toolkit/Utils/SonarQube/$SCRIPT_GET_SONAR_NAME"

      if ! test -e "$SCRIPT_GET_SONAR_NAME_FULL"; then

          echo "ERROR: Script not found '$SCRIPT_GET_SONAR_NAME_FULL'"
          exit 1
      fi

      # shellcheck disable=SC1090
      . "$SCRIPT_GET_SONAR_NAME_FULL"

      if sh "$DIR_TOOLKIT/Utils/SonarQube/configure_sonar_lint.sh" >/dev/null 2>&1; then

        echo "SonarLint has been configured"

      else

        echo "ERROR: SonarLint has failed to configure"
        exit 1
      fi

      RECIPE="$HERE/Recipes/VSCode/settings.json.sh"
      
      if test -e "$RECIPE"; then

        # shellcheck disable=SC1090
        if sh "$SCRIPT_EXTEND_JSON" "$SETTINGS_JSON" "$RECIPE" "$SETTINGS_JSON" >/dev/null 2>&1; then

          echo "VSCode settings have been configured (2)"

        else

          echo "ERROR: VSCode settings have not been configured (2)"
          exit 1
        fi
      fi
  fi
fi

SCRIPT_RECIPE_PRE_OPEN="$HERE/Recipes/Project/project_pre_open.sh"

if test -e "$SCRIPT_RECIPE_PRE_OPEN"; then

    if ! sh "$SCRIPT_RECIPE_PRE_OPEN"; then

        echo "ERROR: Recipe failed, $SCRIPT_RECIPE_PRE_OPEN"
        exit 1
    fi

else

    echo "WARNING: No pre-opening recipe found, $SCRIPT_RECIPE_PRE_OPEN"
fi

"$PROGRAM" "$PROJECT"
