#!/bin/bash

REPO_PATH=$HOME/.server-init

# check for git
printf "${BLUE}Cloning server-init...${NORMAL}\n"
    command -v git >/dev/null 2>&1 || {
        echo "Error: git is not installed"
        exit 1
    }


# clone script repo
env git clone --depth=1 https://github.com/thenav56/server-init $REPO_PATH || {
    printf "Error: git clone of server-init repo failed\n"
    exit 1
}

# Start script execution
cd $REPO_PATH
chmod +x $REPO_PATH/exec.sh
$REPO_PATH/exec.sh
