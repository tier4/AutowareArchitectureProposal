#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Prevent root execution
if [ $(id -u) -eq 0 ]; then
  echo "Do not run setup as root!" >&2
  exit 1
fi

echo "Setting up the pre-build environment for AutowareArchitectureProposal.IV can take up to 45 minutes."
read -p ">  Are you sure you want to run setup? [y/n] " answer

if [[ $answer = [cC] ]]; then
  if !(command -v cowsay  > /dev/null 2>&1); then
    sudo apt install -y cowsay
  fi

  export answer=y
fi

case $answer in
  [yY]* )
    if !(command -v ansible-playbook  > /dev/null 2>&1); then
      sudo apt install -y ansible
    fi

    cd $SCRIPT_DIR/ansible
    ansible-playbook -i localhost, $SCRIPT_DIR/ansible/localhost-setup-ubuntu18.04-devpc.yml -i $SCRIPT_DIR/inventories/local-dev.ini -e AUTOWARE_DIR=$SCRIPT_DIR --ask-become-pass
    echo -e "\e[32mComplete \e[0m"
    ;;
  * )
    echo -e "\e[33mCancelled \e[0m"
    ;;
esac
