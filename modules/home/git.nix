{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rockofox";
        email = "ofelix@pm.me";
      };
      alias = {
        commend = "commit --amend --no-edit";
        grog =
          "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
        please = "push --force-with-lease";
        root = "rev-parse --show-toplevel";
      };
      init.defaultBranch = "main";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      pull.rebase = true;
      push.default = "current";
      push.autoSetupRemote = true;
      commit.gpgsign = false; # TODO
    };
    ignores = [ ".DS_Store" ];
  };
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };
}
