{
  pkgs,
  host,
  ...
}: let
  programsSteam =
    if host.name == "zeus"
    then {}
    else {
      enable = true;
      dedicatedServer.openFirewall = true;
    };
  programsGamemode =
    if host.name == "zeus"
    then {}
    else {
      enable = true;
    };
in {
  programs.steam = programsSteam;
  programs.gamemode = programsGamemode;
}
