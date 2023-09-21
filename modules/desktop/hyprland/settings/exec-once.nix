{
  pkgs,
  host,
  ...
}: let
  polkitkde =
    if host.polkitkde == true
    then ''exec-once = ${pkgs.systemd}/bin/systemctl --user start polkitkde.service''
    else '''';
  kwallet =
    if host.kwallet == true
    then ''exec-once = ${pkgs.systemd}/bin/systemctl --user start kwallet.service''
    else '''';
  misc =
    if host.name == "zeus"
    then ''
      exec-once = ${pkgs.cpupower-gui}/bin/cpupower-gui ene --pref power
      exec-once = ${pkgs.brightnessctl}/bin/brightnessctl set 180''
    else '''';
in {
  wayland.windowManager.hyprland.extraConfig = ''
    ${polkitkde}
    ${kwallet}
    ${misc}
  '';
}
