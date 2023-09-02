{
  pkgs,
  host,
  ...
}: let
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
  modules =
    if host.name == "zeus"
    then {
      left = [
        "custom/launcher"
        "wlr/workspaces"
        "temperature"
        "custom/wall"
      ];
      center = [
        "clock"
      ];
      right = [
        "wireplumber"
        "backlight"
        "battery"
        "custom/powermenu"
        "tray"
      ];
    }
    else {
      left = [
        "custom/launcher"
        "wlr/workspaces"
        "temperature"
        "custom/wall"
      ];
      center = [
        "clock"
      ];
      right = [
        "wireplumber"
        "custom/powermenu"
        "tray"
      ];
    };
in {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    style = ''
             * {
               font-family: "JetBrainsMono Nerd Font";
               font-size: 12pt;
               font-weight: bold;
               border-radius: 10px;
               transition-property: background-color;
               transition-duration: 0.5s;
             }
             @keyframes blink_red {
               to {
                 background-color: rgb(242, 143, 173);
                 color: rgb(26, 24, 38);
               }
             }
             .warning, .critical, .urgent {
               animation-name: blink_red;
               animation-duration: 1s;
               animation-timing-function: linear;
               animation-iteration-count: infinite;
               animation-direction: alternate;
             }
             window#waybar {
               background-color: transparent;
             }
             window > box {
               margin-left: 5px;
               margin-right: 5px;
               margin-top: 5px;
               background-color: rgb(30, 30, 46);
             }
       #workspaces {
               padding-left: 0px;
               padding-right: 4px;
             }
       #workspaces button {
               padding-top: 5px;
               padding-bottom: 5px;
               padding-left: 6px;
               padding-right: 6px;
             }
       #workspaces button.active {
               background-color: rgb(181, 232, 224);
               color: rgb(26, 24, 38);
             }
       #workspaces button.urgent {
               color: rgb(26, 24, 38);
             }
       #workspaces button:hover {
               background-color: rgb(248, 189, 150);
               color: rgb(26, 24, 38);
             }
             tooltip {
               background: rgb(48, 45, 65);
             }
             tooltip label {
               color: rgb(217, 224, 238);
             }
       #custom-launcher {
               font-size: 20px;
               padding-left: 8px;
               padding-right: 6px;
               color: #7ebae4;
             }
       #mode, #clock, #memory, #temperature,#cpu, #custom-wall, #temperature, #backlight, #wireplumber, #network, #battery, #custom-powermenu {
               padding-left: 10px;
               padding-right: 10px;
             }
       #memory {
               color: rgb(181, 232, 224);
             }
       #cpu {
               color: rgb(245, 194, 231);
             }
       #clock {
               color: rgb(217, 224, 238);
             }
      /* #idle_inhibitor {
               color: rgb(221, 182, 242);
             }*/
       #custom-wall {
               color: rgb(221, 182, 242);
          }
       #temperature {
               color: rgb(150, 205, 251);
             }
       #backlight {
               color: rgb(248, 189, 150);
             }
       #wireplumber {
               color: rgb(245, 224, 220);
             }
       #network {
               color: #ABE9B3;
             }

       #network.disconnected {
               color: rgb(255, 255, 255);
             }
       #battery.charging, #battery.full, #battery.discharging {
               color: rgb(250, 227, 176);
             }
       #battery.critical:not(.charging) {
               color: rgb(242, 143, 173);
             }
       #custom-powermenu {
               color: rgb(242, 143, 173);
             }
       #tray {
               padding-right: 8px;
               padding-left: 10px;
             }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = modules.left;
        modules-center = modules.center;
        modules-right = modules.right;
        "custom/launcher" = {
          "format" = " ";
          # "on-click" = "";
          "tooltip" = false;
        };
        "custom/wall" = {
          "on-click" = "${swww-change}/bin/swww-change";
          # "on-click-middle" = "default_wall";
          # "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          "format" = "󰠖 ";
          "tooltip" = false;
        };
        "wlr/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          # "on-scroll-up" = "hyprctl dispatch workspace e+1";
          # "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
        "backlight" = {
          "device" = "amdgpu_bl0";
          "on-click" = "${pkgs.brightnessctl}/bin/brightnessctl set 180";
          "on-scroll-up" = "${pkgs.brightnessctl}/bin/brightnessctl set +1%";
          "on-scroll-down" = "${pkgs.brightnessctl}/bin/brightnessctl set 1%-";
          "format" = "{icon} {percent}%";
          "format-icons" = ["󰃝" "󰃞" "󰃟" "󰃠"];
        };
        "wireplumber" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = ["" "" ""];
          };
          "on-click" = "${pkgs.alsa-utils}/bin/amixer sset Master toggle";
          "on-click-middle" = "${pkgs.pavucontrol}/bin/pavucontrol";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 60;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          # "tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
          "tooltip-format" = "NixOS\nUser: ${host.user}@nixos\nHost: ${host.name}\n\n<tt>{calendar}</tt>";
        };
        # "memory" = {
        #   "interval" = 1;
        #   "format" = "󰍛 {percentage}%";
        #   "states" = {
        #     "warning" = 85;
        #   };
        # };
        # "cpu" = {
        #   "interval" = 1;
        #   "format" = "󰻠 {usage}%";
        # };
        # "network" = {
        #   "format-disconnected" = "󰯡 Disconnected";
        #   "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
        #   "format-linked" = "󰖪 {essid} (No IP)";
        #   "format-wifi" = "󰖩 {essid}";
        #   "interval" = 1;
        #   "tooltip" = false;
        # };
        "temperature" = {
          # "hwmon-path"= "${env:HWMON_PATH}";
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "${pkgs.wlogout}/bin/wlogout";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
