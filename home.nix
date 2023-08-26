{ config, pkgs, host, ... }:

{
  home.username = host.user;
  home.homeDirectory = "/home/${host.user}";
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  imports = (import ./modules/home-default.nix);
}
