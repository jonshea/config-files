#! /bin/bash

CONFIGS_DIR=$(pwd)

CONFIG_FILES=( .profile .inputrc .emacs .irbrc .gitconfig)

for file in ${CONFIG_FILES[@]}
do
    ln -s $CONFIGS_DIR/$file ~/$file
done

KEYBINDINGS_DIR=~/Library/KeyBindings
test  -d $KEYBINDINGS_DIR || mkdir $KEYBINDINGS_DIR
ln -s $CONFIGS_DIR/DefaultKeyBinding.dict $KEYBINDINGS_DIR/DefaultKeyBinding.dict
