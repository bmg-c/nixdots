# fish
{host, ...}: let
  shell =
    if host.shell == "fish"
    then [./fish]
    else [./bash];
in {
  imports = shell;
}
