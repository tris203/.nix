{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } #bitwarden
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } #dark reader
      { id = "kbmfpngjjgdllneeigpgjifpgocmfgmb"; } #reddit enhancement suite
      { id = "hlepfoohegkhhmjieoechaddaejaokhf"; } #refined github
      { id = "jdpblpklojajpopllbckephjndibljbc"; } #twitch channel points auto clicker
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } #ublock origin
      { id = "gppongmhjkpfnbhagpmjfkannfbllamg"; } #wappalyzer
    ];
  };
}
