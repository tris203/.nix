{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        bame = "tris203";
        email = "admin@snappeh.com";
        signingkey = "~/.ssh/github.pub";
      };
      commit.gpgsign = true;
      gpg.format = "ssh";
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
