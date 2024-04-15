{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "tris203";
    userEmail = "admin@snappeh.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/github.pub";
    };
  };

  programs.gh.enable = true;

}
