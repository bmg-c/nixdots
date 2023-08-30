{ pkgs, host, ...}:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "hyprland-session.target";
    };
    settings = {
    mainBar = {
    "layer" = "top"; # Waybar at top layer
    "position" = "top"; # Waybar position (top|bottom|left|right)
    "height" = 30;
    "margin" = "0 0 0 0";
    #"width" = 1350; # Waybar width
    # Choose the order of the modules idle_inhibitor
    "modules-left" = ["custom/launcher" "hyprland/workspaces" "tray" "hyprland/mode"];
    "modules-center" = ["clock"];
    "modules-right" = ["backlight" "pulseaudio" "temperature" "memory" "battery" "custom/power"]; 
    
 # Modules configuration
 
    "hyprland/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = true;
        "format" = "{icon}";
        # "format" = "< %g >";
        # "format_focused"  = "< %g ● >";
        "format-icons" = {
        "1" = "";
        "2" = "";
		"3" = "";
		"4" = "";
		"5" = "";
		"6" = "";
		"7" = "";
		"8" = "";
		"9" = "";
		"10" = "";
        };
    };
    "hyprland/mode" = {
        "format" = "<span style=\"italic\">{}</span>";
    };
    "hyprland/window" = {
        "format" = "~ {app_id}";
    };
    "idle_inhibitor" = {
       "format" = "{icon}";
       "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
    };
    "tray" = {
        "icon-size" = 14;
        "spacing" = 5;
    };
    "clock" = {
        "tooltip-format" = "{:%A %B %d %Y | %H:%M}";
        "format" = "  {:%a %d %b  %I:%M %p}";	#12 hour format
        #"format" = " {:%a %d %b  %H:%M}";	#24 hour format
        "format-alt" = "  {:%d/%m/%Y  %H:%M:%S}";
        #"timezones" = [ "Kolkata" ];
        #"max-length" = 200
        "interval" = 1;
    };
    "cpu" = {
        "format" = "﬙ {usage: >3}%";
        "on-click" = "alacritty -e htop";
    };
    "memory" = {
        "format" = " {: >3}%";
        "on-click" = "alacritty -e htop";
    };
    "temperature" = {
        # "thermal-zone" = 2;
        "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
        "critical-threshold" = 80;
        # "format-critical" = "{temperatureC}°C ";
        "format" = "  {temperatureC}°C";
    };
    "backlight" = {
        # "device" = "acpi_video1";
        "format" = "{icon} {percent: >3}%";
        "format-icons" = ["" ""];
        "on-scroll-down" = "brightnessctl -c backlight set 5%-";
        "on-scroll-up" = "brightnessctl -c backlight set +5%";
    };
    "battery" = {
        "states" = {
            # "good" = 95;
            "warning" = 30;
            "critical" = 15;
        };       
        "format" = "{icon} {capacity: >3}%";
        # "format-good" = ""; # An empty format will hide the module
        # "format-full" = "";
        "format-icons" = ["" "" "" "" ""];
        #"format-icons" = [""; ""; ""; ""; ""; ""; ""; ""; ""; ""]
    };
    "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume: >3}%";
        "format-bluetooth" = "{icon} {volume: >3}%";
        "format-muted" =" muted";
        "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
        };
        "on-click" = "pavucontrol";
        "on-scroll-up" = "pamixer -ui 2 && pamixer --get-volume > $hyprlandSOCK.wob";
        "on-scroll-down" = "pamixer -ud 2 && pamixer --get-volume > $hyprlandSOCK.wob";
    };
    "custom/power" = {
      	"format" ="⏻";
       	"on-click" = "nwgbar";
      	"tooltip" = false;
   };
     "custom/launcher" = {
    	"format" =" ";
    	"on-click" = "exec nwg-drawer -c 7 -is 70 -spacing 23";
    	"tooltip" = false;
};
};
    };
    style = ''
@import "mocha.css";

* {
    color: @lavender;
    border: 0;
    padding: 0 0;
    font-family: FiraCode;
    /* font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; */
    /* font-family: "Hack Nerd Font"; */
    font-size: 18px;
    font-weight: bold;
    /* padding-bottom:4px;
     padding-top: 4px; */
}

window#waybar {
    border: 0px solid rgba(0, 0, 0, 0);
    /* border-radius: 10px; */
    /* background:#2d2a2e; */
    /* background-color: rgba(36, 39, 58, 0.85); */
    background-color: rgba(0, 0, 0, 0);
    /* background-color: shade(#1e1e2e, 0.95); */
}

#workspaces button {
    color: @base;
    border-radius: 50%;
    /* background-color: @base; */
    margin: 0px 0px;
    padding: 4 6 2 0;
}

#workspaces button:hover {
    color: @mauve;
    box-shadow: none; /* Remove predefined box-shadow */
    text-shadow: none; /* Remove predefined text-shadow */
    border: 0px;
    background: none;
}

#workspaces button:hover * {
    color: @mauve;
    background-color: @base;
}

#workspaces * {
    color: whitesmoke;
}

#workspaces {
    border-style: solid;
    background-color: @base;
    opacity: 1;
    border-radius: 10px;
    margin: 8px 0px 8px 8px;
}

#workspaces button.focused {
    color: @mauve;
    border-radius: 20px;
    /* background-color: @flamingo; */
}

#workspaces button.focused * {
    color: @mauve;
}

#mode {
    color: #ebcb8b;
}

#clock,
#custom-swap,
#custom-cava-internal,
#battery,
#cpu,
#memory,
#idle_inhibitor,
#temperature,
#custom-keyboard-layout,
#backlight,
#network,
#pulseaudio,
#mode,
#tray,
#custom-power,
#custom-pacman,
#custom-launcher,
#mpd {
    padding: 5px 8px;
    border-style: solid;
    background-color: shade(@base, 1);
    opacity: 1;
    margin: 8px 0;
}

/* -----------------------------------------------------------------------------
  * Module styles
  * -------------------------------------------------------------------------- */
#mpd {
    border-radius: 10px;
    color: @mauve;
    margin-left: 5px;
    background-color: rgba(0, 0, 0, 0);
}

#mpd.2 {
    border-radius: 10px 0px 0px 10px;
    margin: 8px 0px 8px 6px;
    padding: 4px 12px 4px 10px;
}

#mpd.3 {
    border-radius: 0px 0px 0px 0px;
    margin: 8px 0px 8px 0px;
    padding: 4px;
}

#mpd.4 {
    border-radius: 0px 10px 10px 0px;
    margin: 8px 0px 8px 0px;
    padding: 4px 10px 4px 14px;
}

#mpd.2,
#mpd.3,
#mpd.4 {
    background-color: @base;
    font-size: 14px;
}

#custom-cava-internal {
    border-radius: 10px;
    color: @mauve;
}

#custom-swap {
    border-radius: 10px;
    color: @base;
    margin-left: 15px;
    background-color: @mauve;
}

#clock {
    /* background-color:#a3be8c; */
    color: @sky;
    border-radius: 10px;
    margin: 8px 10px;
}

#backlight {
    color: @yellow;
    /* border-bottom: 2px solid @yellow; */
    border-radius: 10px 0 0 10px;
}

#battery {
    color: #d8dee9;
    /* border-bottom: 2px solid #d8dee9; */
    border-radius: 0 10px 10px 0;
    margin-right: 10px;
}

#battery.charging {
    color: #81a1c1;
    /* border-bottom: 2px solid #81a1c1; */
}

@keyframes blink {
    to {
        color: @red;
        /* border-bottom: 2px solid @red; */
    }
}

#battery.critical:not(.charging) {
    color: #bf616a;
    /* border-bottom: 2px solid #bf616a; */
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#cpu {
    color: @sky;
    /* border-bottom: 2px solid @sky; */
}

#cpu #cpu-icon {
    color: @sky;
}

#memory {
    color: @sky;
}

#network.disabled {
    color: #bf616a;
    /* border-bottom: 2px solid #bf616a; */
}

#network {
    color: @green;
    /* border-bottom: 2px solid @green; */
    border-radius: 10px;
    margin-right: 5px;
}

#network.disconnected {
    color: #bf616a;
    /* border-bottom: 2px solid #bf616a; */
}

#pulseaudio {
    color: @flamingo;
    /* border-bottom: 2px solid @flamingo; */
}

#pulseaudio.muted {
    color: #3b4252;
    /* border-bottom: 2px solid #3b4252; */
}

#temperature {
    color: @teal;
    /* border-bottom: 2px solid @teal; */
    border-radius: 10px 0 0 10px;
}

#temperature.critical {
    color: @red;
    /* border-bottom: 2px solid @red; */
}

#idle_inhibitor {
    background-color: #ebcb8b;
    color: @base;
}

#tray {
    /* background-color: @base; */
    margin: 8px 10px;
    border-radius: 10px;
}

#custom-launcher,
#custom-power {}

#custom-launcher {
    background-color: @mauve;
    color: @base;
    border-radius: 10px;
    padding: 5px 10px;
    margin-left: 15px;
}

#custom-power {
    color: @base;
    background-color: @red;
    border-radius: 10px;
    margin-left: 5px;
    margin-right: 15px;
    padding: 5px 10px;
}

#window {
    border-style: hidden;
    margin-left: 10px;
    /* margin-top:1px;  
     padding: 8px 1rem; */
    margin-right: 10px;
    color: #eceff4;
}

#mode {
    margin-bottom: 3px;
}

#custom-keyboard-layout {
    color: @peach;
    /* border-bottom: 2px solid @peach; */
    border-radius: 0 10px 10px 0;
    margin-right: 10px;
}



/* window#waybar {
     background: #2d2a2e;
 }
 
 * {
     color: #c8b9a9;
     font-family: Ubuntu Mono, sans-serif;
     font-size: 12px;
 }
 
 #workspaces button.focused {
     color: #f2e5bc;
 }
 
 #workspaces button {
     color: #c8b9a9;
 }
 
 .separator {
     background-color: #c8b9a9;
 }
 
 #mode {
     color: #ebcb8b;
 }
 
 #clock {
     color: #a3be8c;
 }
 
 #battery {
     color: #d8dee9;
 }
 
 #battery.charging {
     color: #b48ead;
 }
 
 #battery.critical:not(.charging) {
     color: #bf616a;
 }
 
 #cpu {
     color: #a3be8c;
 }
 
 #memory {
     color: #d3869b;
 }
 
 #network {
     color: #8fbcbb;
 }
 
 #network.disabled {
     color: #bf616a;
 }
 
 #network.disconnected {
     color: #bf616a;
 }
 
 #pulseaudio {
     color: #b48ead;
 }
 
 #pulseaudio.muted {
     color: #bf616a;
 }
 
 #temperature {
     color: #8fbcbb;
 }
 
 #temperature.critical {
     color: #bf616a;
 } */
    '';
  };

  home.file.".config/waybar/mocha.css".text = ''
@define-color base   #1e1e2e;
@define-color mantle #181825;
@define-color crust  #11111b;
@define-color text     #cdd6f4;
@define-color subtext0 #a6adc8;
@define-color subtext1 #bac2de;
@define-color surface0 #313244;
@define-color surface1 #45475a;
@define-color surface2 #585b70;
@define-color overlay0 #6c7086;
@define-color overlay1 #7f849c;
@define-color overlay2 #9399b2;
@define-color blue      #89b4fa;
@define-color lavender  #b4befe;
@define-color sapphire  #74c7ec;
@define-color sky       #89dceb;
@define-color teal      #94e2d5;
@define-color green     #a6e3a1;
@define-color yellow    #f9e2af;
@define-color peach     #fab387;
@define-color maroon    #eba0ac;
@define-color red       #f38ba8;
@define-color mauve     #cba6f7;
@define-color pink      #f5c2e7;
@define-color flamingo  #f2cdcd;
@define-color rosewater #f5e0dc;
  '';
}

