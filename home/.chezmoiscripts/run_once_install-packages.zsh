#!/usr/bin/env zsh
set -eu

if ! [[ -n "$@" ]]; then >&2 echo "Please set chezmoi github username" && return; fi

export XDG_CONFIG_HOME=$HOME/.config
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_CACHE_HOME=$HOME/.cache
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm

export XDG_DATA_HOME=$HOME/.local/share
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$HOME/.local
export CARGO_INSTALL_ROOT=$HOME/.local

mkdir -p $ZDOTDIR
touch $ZDOTDIR/.zshenv
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $CARGO_HOME/env
rm -f $HOME/.profile $ZDOTDIR/.zshenv

cargo install fd-find taplo-cli
cargo install --locked code-minimap bat

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
rm -rf $XDG_CONFIG_HOME/lvim/*

if ! [[ -x $(command -v chezmoi) ]]; then >&2
    sh -c "$(curl -fsLS chezmoi.io/get)" -- $@
    return
else
    chezmoi $@
    return
fi
