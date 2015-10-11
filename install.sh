#!/bin/bash

git submodule init > /dev/null
git submodule update > /dev/null

ROOT="$(readlink -f "${BASH_SOURCE[0]}" | xargs dirname)"
source "${ROOT}/library/swiss.sh/swiss.sh"

swiss::log::info "backup .zshrc as .zshrc~"
cp "${HOME}/.zshrc" "${HOME}/.zshrc~"

swiss::log::info "modify .zshrc to include git-auto in PATH variable"
echo "
# Added by git-auto installation script.
export PATH=\"\${PATH}:$(readlink --canonicalize "${BASH_SOURCE[0]}" | xargs dirname)/source/\"
" >> "${HOME}/.zshrc"

