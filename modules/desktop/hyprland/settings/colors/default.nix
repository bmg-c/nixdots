{...}: let
  colorSchemePath = ".config/hypr/mocha.conf";
in {
  home.file.${colorSchemePath}.text = "${builtins.readFile ./mocha.conf}";
  wayland.windowManager.hyprland.extraConfig = ''
    source = ~/${colorSchemePath}
    general {
           col.active_border=$pink
           col.inactive_border=$surface0
           col.group_border_active=$flamingo
           col.group_border=$surface0
    }
  '';
}
