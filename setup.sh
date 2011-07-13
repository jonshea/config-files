#! /bin/bash

CONFIGS_DIR="$(pwd)"

CONFIG_FILES=( .profile .inputrc .emacs .irbrc .gitconfig functions.el .bash_completion .gemrc)

for file in ${CONFIG_FILES[@]}
do
    ## TODO: This should test if the file is a soft link, and it
    ## should copy a backup somewhere if it is not
    ln -f -s "$CONFIGS_DIR"/"$file" ~/"$file"
done

test -f setup-local.sh && source setup-local.sh

