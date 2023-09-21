{
  pkgs,
  host,
  ...
}: let
  binds =
    if host.name == "zeus"
    then ''
      binde = SUPER, F5, exec, brightnessctl set 15-
      binde = SUPER, F6, exec, brightnessctl set +15
    ''
    else '''';
in {
  wayland.windowManager.hyprland.extraConfig = ''
    bind = SUPER, V, togglefloating,
    bind = SUPER, R, pseudo
    bind = SUPER, I, togglesplit,

    bind = SUPER, J, cyclenext,
    binde = SUPER, H, resizeactive, -20 0
    binde = SUPER, L, resizeactive, 20 0

    bind = SUPER SHIFT, S, exec, ${pkgs.slurp}/bin/slurp -d | ${pkgs.grim}/bin/grim -g - - | ${pkgs.imagemagick}/bin/convert - -shave 1x1 PNG:- | ${pkgs.wl-clipboard}/bin/wl-copy
    binde = SUPER, down, exec, ${pkgs.alsa-utils}/bin/amixer sset Master 5%-
    binde = SUPER, up, exec, ${pkgs.alsa-utils}/bin/amixer sset Master 5%+
    binde = SUPER, M, exec, ${pkgs.alsa-utils}/bin/amixer sset Master toggle
    ${binds}

    bind = SUPER SHIFT, Return, exec, ${pkgs.kitty}/bin/kitty
    bind = CTRL ALT, Backspace, exit,
    bind = SUPER SHIFT, F, fullscreen
    bind = SUPER SHIFT, C, killactive,
    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10
    bind = SUPER SHIFT, 1, movetoworkspacesilent, 1
    bind = SUPER SHIFT, 2, movetoworkspacesilent, 2
    bind = SUPER SHIFT, 3, movetoworkspacesilent, 3
    bind = SUPER SHIFT, 4, movetoworkspacesilent, 4
    bind = SUPER SHIFT, 5, movetoworkspacesilent, 5
    bind = SUPER SHIFT, 6, movetoworkspacesilent, 6
    bind = SUPER SHIFT, 7, movetoworkspacesilent, 7
    bind = SUPER SHIFT, 8, movetoworkspacesilent, 8
    bind = SUPER SHIFT, 9, movetoworkspacesilent, 9
    bind = SUPER SHIFT, 0, movetoworkspacesilent, 10
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
  '';
}
