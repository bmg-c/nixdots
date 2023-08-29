# Hyprland

{ pkgs, host, ...}:

let
  swww-change = pkgs.writeShellScriptBin "swww-change" ''
#!/bin/sh
re="^[0-9]+$"

SOURCE_FOLDER=/home/${host.user}/.config/hypr
STATE_FILE=$SOURCE_FOLDER/.wallpaper_state
WALLPAPER_FOLDER=$SOURCE_FOLDER/wallpapers
WALLPAPER_AMOUNT=$(ls -1q $WALLPAPER_FOLDER | wc -l)

# Sanity checks
if ! [[ -d "$SOURCE_FOLDER" ]]; then
    echo "Source folder doesn't exist."
    exit 1
fi
if ! [[ -d "$WALLPAPER_FOLDER" ]]; then
    echo "Wallpaper folder doesn't exist."
    exit 1
fi
if [ $WALLPAPER_AMOUNT -lt 1 ]; then
    echo "There aren't any wallpapers in the wallpapers folder."
    exit 1
fi

# Defining wallpaper
if [ -f "$STATE_FILE" ]; then
    NUMBER=$(cat $STATE_FILE)
    if ! [[ $NUMBER =~ $re ]] ; then
        NUMBER=$((1 + $RANDOM % $WALLPAPER_AMOUNT))
    else 
        NUMBER=$(($NUMBER + 1))
        if [ $WALLPAPER_AMOUNT -lt $NUMBER ]; then
            NUMBER=1
        fi
    fi
else
    NUMBER=$((1 + $RANDOM % $WALLPAPER_AMOUNT))
fi

# echo "$(cat $STATE_FILE) -> $NUMBER"
echo $NUMBER > $STATE_FILE
${pkgs.swww}/bin/swww img --transition-step 4 --transition-fps 60 --transition-type any "$WALLPAPER_FOLDER/$(ls $WALLPAPER_FOLDER | head -$NUMBER | tail -1)"
  '';


  colorSchemePath = ".config/hypr/mocha.conf";
  launcherConfigPath = ".config/kickoff/config.toml";
  wallpapersFolderPath = ".config/hypr/wallpapers/";


  isNvidiaCard = if host.name == "zeus" then false else true;


  envVariables = if host.name == "zeus" then ''
env = XCURSOR_SIZE,24
env = WLR_NO_HARDWARE_CURSORS,1
  '' else ''
env = XCURSOR_SIZE,24
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
  '';  


  gestures = if host.name == "zeus" then ''
gestures {
    workspace_swipe = true
    workspace_swipe_invert = false
}
  '' else '''';


  input = if host.name == "zeus" then ''
input {
    kb_layout = us,ru
    kb_variant = dvorak,
    kb_options = grp:caps_toggle
    repeat_rate = 38
    repeat_delay = 340
    follow_mouse = 1
    touchpad {
        natural_scroll = false
        tap_button_map = lmr
        # drag_lock = true
        # tap-and-drag = true
    }
    sensitivity = 0
    force_no_accel = false
}
  '' else ''
input {
    kb_layout = us,ru
    kb_variant = dvorak,
    kb_options = grp:caps_toggle
    repeat_rate = 38
    repeat_delay = 340
    follow_mouse = 1
    touchpad {
        natural_scroll = no
    }
    sensitivity = -0.5
    force_no_accel = 1
}
  '';
in {
  home.file.${wallpapersFolderPath} = {
    source = ./wallpapers;
    recursive = true;
  };
  wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      enableNvidiaPatches = isNvidiaCard;
      extraConfig = ''
source=~/${colorSchemePath}
monitor=,preferred,auto,auto

exec-once = ${pkgs.systemd}/bin/systemctl --user start polkitkde.service
exec-once = ${pkgs.systemd}/bin/systemctl --user start kwallet.service
exec-once = ${pkgs.swww}/bin/swww-daemon
exec-once = sleep 0.2 && ${swww-change}/bin/swww-change

${envVariables}

xwayland {
    force_zero_scaling = true
}

${input}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more


    border_size = 3
    gaps_in = 5
    gaps_out = 20

    col.active_border=$pink
    col.inactive_border=$surface0

    col.group_border_active=$flamingo
    col.group_border=$surface0

    cursor_inactive_timeout = 5
    no_cursor_warps = false

    layout = dwindle
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10

    blur {
        enabled = true
        size = 3
        passes = 1
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more new_is_master = true 
}

${gestures}

misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
}


windowrule = workspace 2, ^(brave-browser)$


# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod SHIFT, Return, exec, ${pkgs.kitty}/bin/kitty
bind = $mainMod SHIFT, C, killactive, 
bind = CTRL ALT, Backspace, exit, 
bind = $mainMod, V, togglefloating, 
bind = $mainMod, P, exec, ${pkgs.kickoff}/bin/kickoff
bind = $mainMod, R, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod SHIFT, F, fullscreen
bind = $mainMod, F11, exec, ${swww-change}/bin/swww-change

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
      '';
  };

  home.file.${launcherConfigPath}.text =
    "${builtins.readFile ./config.toml}";

  home.file.${colorSchemePath}.text =
    "${builtins.readFile ./mocha.conf}";
}
