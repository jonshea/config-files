#! /bin/bash

CONFIGS_DIR=$(pwd)

CONFIG_FILES=( .profile .inputrc .emacs .irbrc .gitconfig)

for file in ${CONFIG_FILES[@]}
do
    ln -s $CONFIGS_DIR/$file ~/$file
done


