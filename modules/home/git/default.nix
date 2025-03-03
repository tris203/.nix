{ ... }: {
  programs.git = {
    enable = true;
    userName = "tris203";
    userEmail = "admin@snappeh.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/github.pub";
      credential = {
        "https://github.com" = { helper = "!gh auth git-credential"; };
        "https://gist.github.com" = { helper = "!gh auth git-credential"; };
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
  };
}
