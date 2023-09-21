# fish
{host, ...}: let
  shell =
    if host.shell == "fish"
    then [./fish/config.nix]
    else [./bash/config.nix];
in {
  imports = shell;
}
