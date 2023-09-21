{pkgs, ...}: let
  launcherConfigPath = ".config/kickoff/config.toml";
in {
  home.file.${launcherConfigPath}.text = "${builtins.readFile ./config.toml}";
  wayland.windowManager.hyprland.extraConfig = ''
    bind = SUPER, P, exec, ${pkgs.kickoff}/bin/kickoff
  '';
}
