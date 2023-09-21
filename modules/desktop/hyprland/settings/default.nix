{...}: {
  imports = [
    ./env.nix
    ./colors
    ./input.nix
    ./bind.nix
    ./windowrule.nix
    ./exec-once.nix
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    monitor=,preferred,auto,auto

    general {
        border_size = 3
        gaps_in = 5
        gaps_out = 20
        cursor_inactive_timeout = 5
        no_cursor_warps = false
        layout = dwindle
    }
    decoration {
        rounding = 10
        blur {
            enabled = true
            size = 3
            passes = 1
        }
        drop_shadow = false
        # shadow_range = 4
        # shadow_render_power = 3
        # col.shadow = $surface0
        # col.shadow_inactive = $surface0
    }
    animations {
        enabled = yes
        bezier = windowsBezier, 0.16, 1, 0.3, 1
        bezier = workspacesBezier, 0.85, 0, 0.15, 1
        animation = windows, 1, 4, windowsBezier, slide
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 3, default
        animation = workspaces, 1, 3, workspacesBezier, slide
    }
    dwindle {
        pseudotile = yes
        preserve_split = yes # you probably want this
    }
    xwayland {
        force_zero_scaling = true
        use_nearest_neighbor = false
    }
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }
  '';
}
