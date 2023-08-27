# QWERTY shortcuts for dvorak layout, kwallet, kde polkit agent, pfetch with
# kitties, gtk theming (dconf), greetd (tuigreet)

{ pkgs, host, ... }:

let
  dvorak = {
    package = pkgs.stdenv.mkDerivation rec {
      name = "dvorak";
      src = pkgs.fetchFromGitHub {
        owner = "bmg-c";
        repo = "dvorak";
        rev = "master";
        sha256 = "fieNcEviTGagXO+ivizamlSwo5NCndpJuNPBwBbbD2M=";
      };
      installPhase = ''
        mkdir -p $out/bin
        cp dvorak $out/bin/dvorak
      '';
    };
    service = {
      enable = true;
      description = "Dvorak Virtual Keyboard";
      serviceConfig.ExecStart = if host.name == "zeus" then ''${dvorak.package}/bin/dvorak -d /dev/input/by-path/platform-i8042-serio-0-event-kbd -m "AT Translated Set 2 keyboard"'' else '''';
      wantedBy = [ "default.target" ];
    };
  };


  kwallet = {
    package = pkgs.libsForQt5.kwallet;
    service = {  
      enable = true;
      description = "KDE Wallet Service";
      serviceConfig.ExecStart = ''${pkgs.libsForQt5.kwallet}/bin/kwalletd5'';
      wantedBy = [ "default.target" ];
    };
  };


  polkitkde = {
    package = pkgs.libsForQt5.kwallet;
    service = {  
      enable = true;
      description = "KDE Polkit Agent";
      serviceConfig.ExecStart = ''${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1'';
      wantedBy = [ "default.target" ];
    };
  };


  pfetch = {
    package = pkgs.stdenv.mkDerivation rec {
      name = "pfetch";
      src = pkgs.fetchFromGitHub {
        owner = "andreasgrafen";
        repo = "pfetch-with-kitties";
        rev = "f70c7d1a4b977efb1051b4ba1fd553d4d6708dba";
        sha256 = "1s4ypIemW750a4y0sIeI2JgX3tJP+sblDjFl/CWO4ps=";
      };
      installPhase = ''
        mkdir -p $out/bin
        cp pfetch $out/bin/pfetch
      '';
    };
  };


in {
  systemd.services.dvorak = dvorak.service;
  systemd.user.services.kwallet = kwallet.service;
  systemd.user.services.polkitkde = polkitkde.service;

  
  programs.dconf.enable = true;


  services.xserver.displayManager.lightdm.enable = false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
      };
    };
  };


  environment.systemPackages = [
    dvorak.package
    kwallet.package
    polkitkde.package
    pfetch.package
  ];
}
