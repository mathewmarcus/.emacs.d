#!/bin/bash

EMACS=$(which emacs)

CC_MODE='http://sourceforge.net/projects/cc-mode/files/cc-mode/5.33/cc-mode-5.33.tar.gz/download'
HOBER_THEME='https://raw.githubusercontent.com/emacs-jp/replace-colorthemes/master/hober-theme.el'
YANIPPETS='https://github.com/AndreaCrotti/yasnippet-snippets'

WGET_PLUGINS=("$CC_MODE", "$HOBER_THEME")
GIT_PLUGINS=("$YASNIPPETS")
PIP_DEPENDENCIES=('rope', 'flake8', 'importmagic', 'autopep8', 'yapf')


function setup_cc_mode() {
    mv cc-mode* cc-mode
    tar -xzvf cc-mode
    cd cc-mode
    $EMACS -batch -no-site-file -q -f batch-byte-compile cc-*.el
    rm *.el
    cd -
}


cd ~/.emacs.d/plugins
printf 'Downloading external plugins...\n'

for plugin in ${WGET_PLUGINS[*]}; do
    wget "$plugin"
done

for plugin in ${GIT_PLUGINS[*]}; do
    git clone "$plugin"
done


printf 'Downloading pip dependencies...\n'

for package in ${PIP_DEPENDENCIES[*]}; do
    pip install -Ur "$package"
done

setup_cc_mode

