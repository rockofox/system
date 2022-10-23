{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    difftastic.enable = true;
    userName = "rocko";
    userEmail = "ofelix@pm.me";
    ignores = [ ".*" "!.envrc" "!.gitignore" "!.gitkeep" ];
    aliases = {
      commend = "commit --amend --no-edit";
      grog = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      please = "push --force-with-lease";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      init.defaultBranch = "master";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      pull.rebase = true;
      push.default = "current";
      push.autoSetupRemote = true;
    };
  };
}
