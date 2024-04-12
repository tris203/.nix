{ pkgs, inputs,... }:


{

  home-manager = {
  extraSpecialArgs = { inherit inputs; };
  users = {
  "tris" = {
  programs.git = {
    enable = true;
    userName = "tris203";
    userEmail = "admin@snappeh.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/github.pub";
      };
    # Other git settings here
  };
  };
  };
  };


  environment.systemPackages = with pkgs; [
  gh
  ];
}
