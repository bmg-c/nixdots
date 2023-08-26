# htop

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
}
