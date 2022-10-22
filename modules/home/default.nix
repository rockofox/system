{ pkgs, lib, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rocko";
  # home.homeDirectory = "/Users/rocko";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  manual.manpages.enable = false;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.home-manager.manual.manpages.enable = false;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch";
      hr = "home-manager switch";
    };
    initExtra = ''
      if test -e /etc/static/zshrc; then . /etc/static/zshrc; fi
      export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH;
      export PATH=/run/current-system/sw/bin:$PATH
      export PATH=$HOME/.spicetify:$PATH
      source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      export EDITOR=nvim
      export VISUAL=$EDITOR
      	'';
    history = {
      size = 10000;
      path = "$HOME/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "arrow";
    };
  };
  imports = [ 
    ./neovim 
    ./yabai.nix 
  ];
}
