# htop, gtk theme, mpv
{
  pkgs,
  host,
  ...
}: {
  imports = [
    ./gtk
    ./qt
    ./mpv
    ./btop
  ];

  # programs.command-not-found.enable = true;

  # services.mako = {
  #   enable = true;
  # };
  # home.packages = with pkgs; [ libnotify ];
}
