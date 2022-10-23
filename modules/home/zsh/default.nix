{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
  ];
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      ls = "exa --icons -L1";
      ll = "exa --tree --icons --long -L1";
      exa = "exa --tree --icons";
      update = "sudo nixos-rebuild switch";
      hr = "home-manager switch";
    };
    initExtra = ''
      source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      source "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh"
      source "${pkgs.fzf}/share/fzf/completion.zsh"
      source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/lib/zsh-ls-colors/ls-colors.zsh"
      ${builtins.readFile ./init.sh}
    '';
    history = {
      size = 10000;
      path = "$HOME/zsh/history";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "🦊";
        error_symbol = "😿";
        vicmd_symbol = "😸";
      };
    };
  };
}
