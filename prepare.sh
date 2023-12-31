#!/bin/bash

if [ -z "$SUBMODULES_HOME" ]; then

  echo "ERROR: The SUBMODULES_HOME is not defined"
  exit 1
fi

# shellcheck disable=SC2012
FILES_COUNT=$(ls "$SUBMODULES_HOME" -1 | wc -l)

if [ "$FILES_COUNT" = "0" ]; then

  echo "ERROR: The SUBMODULES_HOME points to empty directory"
  exit 1
fi

if test -e "$SUBMODULES_LOAD_ENVIRONMENT"; then

    echo "Loading the environment"
    
    # shellcheck disable=SC1090
    . "$SUBMODULES_LOAD_ENVIRONMENT" >/dev/null 2>&1
fi

if [ -n "$SUBMODULES_PRIVATE_HOME" ] && [ -n "$SUBMODULES_PRIVATE_RECIPES" ]; then
    
    SCRIPT_INSTALL_PRIVATE_MODULES="$SUBMODULES_HOME/Software-Toolkit/Utils/Git/install_private_submodules.sh"

    if ! test -e "$SCRIPT_INSTALL_PRIVATE_MODULES"; then

        echo "ERROR: Script not found '$SCRIPT_INSTALL_PRIVATE_MODULES'"
        exit 1
    fi

    if ! bash "$SCRIPT_INSTALL_PRIVATE_MODULES" "$SUBMODULES_PRIVATE_HOME" "$SUBMODULES_PRIVATE_RECIPES"; then

        echo "ERROR: Private modules installation failed"
        exit 1
    fi
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

SCRIPT_PATHS="$SUBMODULES_HOME/Software-Toolkit/Utils/Sys/paths.sh"

if ! test  -e "$SCRIPT_PATHS"; then

    echo "ERROR: Prepare script not found '$SCRIPT_PATHS'"
    exit 1
fi

# shellcheck disable=SC1090
. "$SCRIPT_PATHS"

SCRIPT_LINK="$SUBMODULES_HOME/Software-Toolkit/Utils/Sys/Filesystem/link.sh"

if ! test -e "$SCRIPT_LINK"; then

  echo "ERROR: Script not found '$SCRIPT_LINK'"
  exit 1
fi

# shellcheck disable=SC1090
. "$SCRIPT_LINK"

DIR_RECIPES_ICONIC="Recipes/Iconic"
DIR_RECIPES_VSCODE="Recipes/VSCode"
DIR_RECIPES_PROJECT="Recipes/Project"
DIR_RECIPES_SONARQUBE="Recipes/SonarQube"
DIR_RECIPES_INSTALLABLE="Recipes/Installable"

DIR_RECIPES_ICONIC_FULL="$PATH_PROJECT/$DIR_RECIPES_ICONIC"
DIR_RECIPES_VSCODE_FULL="$PATH_PROJECT/$DIR_RECIPES_VSCODE"
DIR_RECIPES_PROJECT_FULL="$PATH_PROJECT/$DIR_RECIPES_PROJECT"
DIR_RECIPES_SONARQUBE_FULL="$PATH_PROJECT/$DIR_RECIPES_SONARQUBE"
DIR_RECIPES_INSTALLABLE_FULL="$PATH_PROJECT/$DIR_RECIPES_INSTALLABLE"

DIR_RUN_TEST="Run/Test"
DIR_RUN_HTTPD="Run/Httpd"
DIR_RUN_ICONIC="Run/Iconic"
DIR_RUN_PROJECT="Run/Project"
DIR_RUN_INSTALL="Run/Install"
DIR_RUN_INCLUDE_CURL="Run/Include/Curl"

DIR_RUN_TEST_FULL="$PATH_PROJECT/$DIR_RUN_TEST"
DIR_RUN_HTTPD_FULL="$PATH_PROJECT/$DIR_RUN_HTTPD"
DIR_RUN_ICONIC_FULL="$PATH_PROJECT/$DIR_RUN_ICONIC"
DIR_RUN_PROJECT_FULL="$PATH_PROJECT/$DIR_RUN_PROJECT"
DIR_RUN_INSTALL_FULL="$PATH_PROJECT/$DIR_RUN_INSTALL"
DIR_RUN_INCLUDE_CURL_FULL="$PATH_PROJECT/$DIR_RUN_INCLUDE_CURL"

INIT_DIR "$DIR_RUN_TEST_FULL"
INIT_DIR "$DIR_RUN_HTTPD_FULL"
INIT_DIR "$DIR_RUN_ICONIC_FULL"
INIT_DIR "$DIR_RUN_PROJECT_FULL"
INIT_DIR "$DIR_RUN_INSTALL_FULL"
INIT_DIR "$DIR_RUN_INCLUDE_CURL_FULL"

INIT_DIR "$DIR_RECIPES_ICONIC_FULL"
INIT_DIR "$DIR_RECIPES_VSCODE_FULL"
INIT_DIR "$DIR_RECIPES_PROJECT_FULL"
INIT_DIR "$DIR_RECIPES_SONARQUBE_FULL"
INIT_DIR "$DIR_RECIPES_INSTALLABLE_FULL"

FILE_SYNC="sync"
FILE_TEST="test"
FILE_CLONE="clone"
FILE_OPEN="do_open"
FILE_PREPARE="prepare"
FILE_PULL_ALL="pull_all"
FILE_PUSH_ALL="push_all"

FILE_RUN_TEST_MAIN="main.sh"
FILE_RUN_PROJECT_OPEN="open.sh"
FILE_RUN_INSTALL_FONTS="fonts.sh"
FILE_RUN_INSTALL_VSCODE="vscode.sh"
FILE_RUN_ICONIC_ICONIFY="iconify.sh"
FILE_RUN_ICONIC_DO_BRANDING="do_branding.sh"
FILE_RUN_HTTPD_SHARED_LOCAL="shared_Local.sh"
FILE_RUN_INCLUDE_CURL_API_CALL="api_call.sh"
FILE_RUN_INCLUDE_CURL_TELEGRAM_BOT="telegram_bot.sh"

FILE_RECIPES_PROJECT_PRE_OPEN="pre_open.sh"
FILE_RECIPES_PROJECT_PROJECT_PRE_OPEN="project_pre_open.sh"
FILE_RECIPES_ICONIC_LAUNCHER_PARAMS="launcher_parameters.sh"

FILE_RECIPES_SONARQUBE_INSTALLATION_PARAMETERS="installation_parameters_sonarqube.sh"

FILE_RECIPES_VSCODE_DEFAULTS="defaults.sh"
FILE_RECIPES_VSCODE_SETTINGS="settings.json.sh"
FILE_RECIPES_VSCODE_USER_SETTINGS="settings.user.json.sh"
FILE_RECIPES_VSCODE_INSTALLLATION_PARAMS="installation_parameters_vscode.sh"

FILE_RECIPES_INSTALLABLE_PREPARE="prepare.sh"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_SYNC" "$PATH_PROJECT/$FILE_SYNC"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_TEST" "$PATH_PROJECT/$FILE_TEST"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_OPEN" "$PATH_PROJECT/$FILE_OPEN"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_CLONE" "$PATH_PROJECT/$FILE_CLONE"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_PREPARE" "$PATH_PROJECT/$FILE_PREPARE"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_PULL_ALL" "$PATH_PROJECT/$FILE_PULL_ALL"
LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$FILE_PUSH_ALL" "$PATH_PROJECT/$FILE_PUSH_ALL"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_ICONIC/$FILE_RECIPES_ICONIC_LAUNCHER_PARAMS" \
  "$DIR_RECIPES_ICONIC_FULL/$FILE_RECIPES_ICONIC_LAUNCHER_PARAMS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_PROJECT/$FILE_RECIPES_PROJECT_PRE_OPEN" \
  "$DIR_RECIPES_PROJECT_FULL/$FILE_RECIPES_PROJECT_PRE_OPEN"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_PROJECT/$FILE_RECIPES_PROJECT_PROJECT_PRE_OPEN" \
  "$DIR_RECIPES_PROJECT_FULL/$FILE_RECIPES_PROJECT_PROJECT_PRE_OPEN"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_SONARQUBE/$FILE_RECIPES_SONARQUBE_INSTALLATION_PARAMETERS" \
  "$DIR_RECIPES_SONARQUBE_FULL/$FILE_RECIPES_SONARQUBE_INSTALLATION_PARAMETERS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_VSCODE/$FILE_RECIPES_VSCODE_DEFAULTS" \
  "$DIR_RECIPES_VSCODE_FULL/$FILE_RECIPES_VSCODE_DEFAULTS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_VSCODE/$FILE_RECIPES_VSCODE_SETTINGS" \
  "$DIR_RECIPES_VSCODE_FULL/$FILE_RECIPES_VSCODE_SETTINGS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_VSCODE/$FILE_RECIPES_VSCODE_USER_SETTINGS" \
  "$DIR_RECIPES_VSCODE_FULL/$FILE_RECIPES_VSCODE_USER_SETTINGS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_VSCODE/$FILE_RECIPES_VSCODE_INSTALLLATION_PARAMS" \
  "$DIR_RECIPES_VSCODE_FULL/$FILE_RECIPES_VSCODE_INSTALLLATION_PARAMS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RECIPES_INSTALLABLE/$FILE_RECIPES_INSTALLABLE_PREPARE" \
  "$DIR_RECIPES_INSTALLABLE_FULL/$FILE_RECIPES_INSTALLABLE_PREPARE"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_TEST/$FILE_RUN_TEST_MAIN" \
  "$DIR_RUN_TEST_FULL/$FILE_RUN_TEST_MAIN"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_HTTPD/$FILE_RUN_HTTPD_SHARED_LOCAL" \
  "$DIR_RUN_HTTPD_FULL/$FILE_RUN_HTTPD_SHARED_LOCAL"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_ICONIC/$FILE_RUN_ICONIC_ICONIFY" \
  "$DIR_RUN_ICONIC_FULL/$FILE_RUN_ICONIC_ICONIFY"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_ICONIC/$FILE_RUN_ICONIC_DO_BRANDING" \
  "$DIR_RUN_ICONIC_FULL/$FILE_RUN_ICONIC_DO_BRANDING"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_PROJECT/$FILE_RUN_PROJECT_OPEN" \
  "$DIR_RUN_PROJECT_FULL/$FILE_RUN_PROJECT_OPEN"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_INSTALL/$FILE_RUN_INSTALL_VSCODE" \
  "$DIR_RUN_INSTALL_FULL/$FILE_RUN_INSTALL_VSCODE"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_INSTALL/$FILE_RUN_INSTALL_FONTS" \
  "$DIR_RUN_INSTALL_FULL/$FILE_RUN_INSTALL_FONTS"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_INCLUDE_CURL/$FILE_RUN_INCLUDE_CURL_TELEGRAM_BOT" \
  "$DIR_RUN_INCLUDE_CURL_FULL/$FILE_RUN_INCLUDE_CURL_TELEGRAM_BOT"

LINK_FILE_TO_DESTINATION "$SUBMODULES_HOME/$DIR_RUN_INCLUDE_CURL/$FILE_RUN_INCLUDE_CURL_API_CALL" \
  "$DIR_RUN_INCLUDE_CURL_FULL/$FILE_RUN_INCLUDE_CURL_API_CALL"
