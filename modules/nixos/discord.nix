{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      vesktop
      (discord.override {
        withVencord = true;
        withOpenASAR = true;
      })
    ];
}
