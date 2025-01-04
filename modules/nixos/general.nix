{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nautilus
    gnome-screenshot
    calibre
    # obsidian
    spotify
    vscode
    tokyo-night-gtk
  ];

  nix.settings = {
    substituters =
      [ "https://cosmic.cachix.org/" "https://ghostty.cachix.org" ];
    trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };

}
