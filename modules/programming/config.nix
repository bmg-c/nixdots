{
  pkgs,
  host,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pkgconfig
    cmake
    xorg.libxcb
    xorg.libXfixes
    libxkbcommon
    fontconfig
    fontconfig.lib
    wayland
    libxkbcommon
    libGL
    wayland
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libX11
    zlib
    mono6
  ];
}
