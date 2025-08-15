function maybe_source()
{
    if [ -e "$1" ]; then
        source "$1"
    fi
}

maybe_source /etc/static/zshrc
maybe_source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH;
export PATH=/run/current-system/sw/bin:$PATH
export PATH=$HOME/.spicetify:$PATH
export PATH=$HOME/.ghcup/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export EDITOR=nvim
export VISUAL=$EDITOR
export FZF_DEFAULT_COMMAND='ag -g ""'
export DIRENV_LOG_FORMAT=
export BAT_STYLE=plain
export BASE16_SHELL=$HOME/.config/base16-shell

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→
bindkey "^[[3~" delete-char

# Enable vi mode
bindkey -v

precmd () {print -Pn "\e]0;%2~\a"}
if command -v github-copilot-cli &> /dev/null
then
    eval "$(github-copilot-cli alias -- "$0")"
fi

# source ~/.wasienv/wasienv.sh
# source ~/.ghc-wasm/env
source "$HOME/.sdkman/bin/sdkman-init.sh"
