{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.discord.override {
      withVencord = true;
      withOpenASAR = true;
    })
  ];
}
