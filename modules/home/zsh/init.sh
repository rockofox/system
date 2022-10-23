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
