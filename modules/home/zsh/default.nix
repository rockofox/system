{ config, pkgs, sensitive, ... }:
{
  home.packages = with pkgs; [ fzf ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # enableSyntaxHighlighting = true;
    shellAliases = {
      ls = "eza --icons -L1";
      ll = "eza --tree --icons --long -L1";
      eza = "eza --tree --icons";
      rebuild =
        "cd ${sensitive.lib.systemFlakePath} && git add -NA . && darwin-rebuild switch --flake .#darwin && cd -";
      ngit = "vim -c \"Neogit\"";
    };
    autocd = true;
    initExtra = ''
      source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      source "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh"
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source "${pkgs.fzf}/share/fzf/completion.zsh"
      source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/lib/zsh-ls-colors/ls-colors.zsh"
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      export ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=#${
        builtins.substring 0 3 config.colorScheme.palette.base08
      }
      export ZSH_HIGHLIGHT_STYLES[precommand]=fg=#${
        builtins.substring 0 3 config.colorScheme.palette.base08
      }
      export ZSH_HIGHLIGHT_STYLES[arg0]=fg=#${
        builtins.substring 0 3 config.colorScheme.palette.base08
      }
      zvm_after_init_commands+=('source ${pkgs.fzf}/share/fzf/completion.zsh')
      zvm_after_init_commands+=('source ${pkgs.fzf}/share/fzf/key-bindings.zsh')
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
        success_symbol = "❯";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold green)";
      };
      gcloud.disabled = true;
      battery.disabled = true;
      nodejs.symbol = " ";
      java.symbol = " ";
      rust.symbol = " ";
      package.symbol = " ";
      hostname = { ssh_only = true; };
      git_status = {
        format = "([\\[ $all_status$ahead_behind\\]]($style) )";
        conflicted = " ";
        deleted = "﫧";
        modified = " ";
        stashed = " ";
        staged = "ﱐ ";
        renamed = " ";
        untracked = " ";
        diverged = " ";
        ahead = " ";
        behind = " ";
      };
    };
  };
}
