#!/bin/bash

set -e

SYSTEM=$(uname)
EMACS=$(which emacs)

CC_MODE='http://sourceforge.net/projects/cc-mode/files/cc-mode/5.33/cc-mode-5.33.tar.gz'
HOBER_THEME='https://raw.githubusercontent.com/emacs-jp/replace-colorthemes/master/hober-theme.el'
YASNIPPETS='https://github.com/joaotavora/yasnippet'
# YASNIPPETS='https://github.com/AndreaCrotti/yasnippet-snippets'

WGET_PLUGINS=("$CC_MODE")
GIT_PLUGINS=("${YASNIPPETS}")


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
    wget -q "$plugin"
done

for plugin in ${GIT_PLUGINS[*]}; do
    echo $plugin
    git clone -q --recursive "$plugin"
done

printf 'Bytecode compiling cc-mode/*el'
setup_cc_mode > /dev/null
