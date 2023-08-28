# htop, gtk theme, mpv

{ config, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      fields = with config.lib.htop.fields; [
        PERCENT_CPU
        PERCENT_MEM
        COMM
      ];
    };
  };


  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Pink-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [];
        variant = "mocha";
      };
    };
  };  


  programs.mpv.enable = true;
}
