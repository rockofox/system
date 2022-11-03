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
export EDITOR=nvim
export VISUAL=$EDITOR
export TERM=xterm-256color
export FZF_DEFAULT_COMMAND='ag -g ""'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→

precmd () {print -Pn "\e]0;%2~\a"}
