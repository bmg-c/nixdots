# QWERTY shortcuts for dvorak layout, kwallet

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
    serviceExecStart = if host.name == "zeus" then ''${dvorak.package}/bin/dvorak -d /dev/input/by-path/platform-i8042-serio-0-event-kbd -m "AT Translated Set 2 keyboard"'' else "";
  };
  kwallet = {
    package = pkgs.libsForQt5.kwallet;
    service = {  
      enable = true;
      description = "KDE Wallet Service";
      serviceConfig = {
        ExecStart = ''${pkgs.libsForQt5.kwallet}/bin/kwalletd5'';
      };
      wantedBy = [ "default.target" ];
    };
  };
in {
  # services.udev.extraRules = ''SUBSYSTEM=="input", ACTION=="add", RUN+="${pkgs.systemd}/bin/systemctl start dvorak.service"'';
  systemd.services.dvorak = {
    enable = true;
    description = "Dvorak Virtual Keyboard";
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      ExecStart = dvorak.serviceExecStart;
    };
  };


  systemd.user.services.kwallet = kwallet.service;
  

  environment.systemPackages = [
    dvorak.package
    kwallet.package
  ];
}
