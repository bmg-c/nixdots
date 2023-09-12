{
  lib,
  pkgs,
}:
pkgs.stdenv.mkDerivation {
  pname = "jdt-language-server";
  version = "1.26.0";

  src = pkgs.fetchurl {
    url = https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.26.0/jdt-language-server-1.26.0-202307271613.tar.gz;
    sha256 = "sha256-ul/l7jsqg5UofiSu8gzm4Xg0z46HcRfmyqysamiKbFM=";
  };

  nativeBuildInputs = with pkgs; [makeWrapper];

  buildPhase = ''
    mkdir -p jdt-language-server
    tar xfz $src -C jdt-language-server
  '';

  installPhase = ''
    mkdir -p $out/bin $out/libexec
    cp -a jdt-language-server $out/libexec
    makeWrapper $out/libexec/jdt-language-server/bin/jdtls $out/bin/jdtls --prefix PATH : ${lib.makeBinPath [pkgs.python3]}
  '';

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
}
