#!/bin/bash

set -e

SYSTEM=$(uname)
EMACS=$(which emacs)

CC_MODE='http://sourceforge.net/projects/cc-mode/files/cc-mode/5.33/cc-mode-5.33.tar.gz'
HOBER_THEME='https://raw.githubusercontent.com/emacs-jp/replace-colorthemes/master/hober-theme.el'
YASNIPPETS='https://github.com/AndreaCrotti/yasnippet-snippets'

WGET_PLUGINS=("$CC_MODE" "$HOBER_THEME")
GIT_PLUGINS=("$YASNIPPETS")
PIP_DEPENDENCIES=('jedi' 'flake8' 'importmagic' 'autopep8' 'yapf')


function setup_cc_mode() {
    mv cc-mode* cc-mode    
    tar -xzvf cc-mode
    rm cc-mode
    mv cc-mode* cc-mode    
    cd cc-mode
    $EMACS -batch -no-site-file -q -f batch-byte-compile cc-*.el
    rm *.el
    cd -
}


mkdir -p ~/.emacs.d/plugins
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
    if [ $SYSTEM == 'Linux' ]; then
	sudo pip install -U "$package"
    else
	pip install -U "$package"	
    fi
done

setup_cc_mode

