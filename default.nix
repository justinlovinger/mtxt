{ pkgs ? (import (builtins.fetchGit {
  url = "https://github.com/NixOS/nixpkgs.git";
  ref = "nixos-20.09";
  rev = "19db3e5ea2777daa874563b5986288151f502e27";
}) {}) }:

pkgs.stdenv.mkDerivation rec {
  pname = "mtxt";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  buildPhase = ''
    patchShebangs mtxt
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv mtxt $out/bin/
  '';

  postFixup = ''
    wrapProgram $out/bin/mtxt --prefix PATH : ${pkgs.stdenv.lib.makeBinPath [
      pkgs.mblaze
    ]}
  '';

  meta = with pkgs.stdenv.lib; {
    description = "Send quick and easy text messages with `mblaze`";
    homepage = "https://github.com/JustinLovinger/mtxt";
    license = licenses.mit;
  };
}
