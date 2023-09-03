{
  pkgs,
  host,
  lib,
  ...
}: let
  programsSteam =
    if host.name == "zeus"
    then {}
    else {
      # enable = true;
      # dedicatedServer.openFirewall = true;
    };
  programsGamemode =
    if host.name == "zeus"
    then {}
    else {
      #enable = true;
    };
in {
  programs.steam = programsSteam;
  programs.gamemode = programsGamemode;
  # environment.systemPackages = with pkgs; [ protonup-qt ];
  # home.activation.steam = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     $DRY_RUN_CMD sed 's/^Exec=/&nvidia-offload /' \
  #       ${pkgs.steam}/share/applications/steam.desktop \
  #       > ~/.local/share/applications/steam.desktop
  #     $DRY_RUN_CMD chmod +x ~/.local/share/applications/steam.desktop
  #   '';
}
