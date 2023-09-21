{...}: {
  programs.waybar.style = ''
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
}
