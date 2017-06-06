#!/bin/bash

CC_MODE='http://sourceforge.net/projects/cc-mode/files/cc-mode/5.33/cc-mode-5.33.tar.gz/download'
HOBER_THEME='https://github.com/emacs-jp/replace-colorthemes/blob/master/hober-theme.el'
YANIPPETS='https://github.com/AndreaCrotti/yasnippet-snippets'

WGET_PLUGINS=("$CC_MODE", "$HOBER_THEME")
GIT_PLUGINS=("$YASNIPPETS")


printf 'Cloning .emacs.d directory...\n'
git clone https://github.com/mathewmarcus/.emacs.d

cd ~/.emacs.d/plugins
printf 'Downloading external plugins...\n'

for plugin in ${WGET_PLUGINS[*]}; do
    wget "$plugin"

for plugin in ${GIT_PLUGINS[*]}; do
    git clone "$plugin"
