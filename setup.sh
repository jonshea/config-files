#! /bin/bash

CONFIGS_DIR="$(pwd)"

CONFIG_FILES=( .zshrc .emacs .irbrc .gitconfig functions.el .bash_completion .gemrc .ripgreprc)

for file in ${CONFIG_FILES[@]}
do
    # `-b` should create a backup if destination already exists
    ln -b -f -s "${CONFIGS_DIR}"/"${file}" ~/"${file}"
done

test -f setup-local.sh && source setup-local.sh

