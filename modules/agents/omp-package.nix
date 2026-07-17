{ pkgs, lib }:

let
  version = "16.1.16";
  system = pkgs.stdenv.hostPlatform.system;

  sources = {
    x86_64-linux = {
      url = "https://github.com/can1357/oh-my-pi/releases/download/v${version}/omp-linux-x64";
      hash = "sha256-68iuvhqOnrQobSoQhwIPckTMsjADU246CPeEbPUfaXw=";
    };
    aarch64-linux = {
      url = "https://github.com/can1357/oh-my-pi/releases/download/v${version}/omp-linux-arm64";
      hash = "sha256-8g4SZjLlliwwUWKOR78BUmozk5Vr9o7yizFy2ndhzds=";
    };
  };

  src = pkgs.fetchurl (sources.${system} or (throw "omp: unsupported system ${system}"));

in
pkgs.runCommandLocal "omp-${version}" {
  inherit src;
  nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.makeWrapper ];
  meta = {
    description = "Oh My Pi — terminal coding agent with batteries included";
    homepage = "https://omp.sh";
    license = lib.licenses.mit;
    mainProgram = "omp";
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
} ''
  mkdir -p $out/bin
  cp $src $out/bin/omp
  chmod +x $out/bin/omp
  chmod +w $out/bin/omp
  autoPatchelf $out/bin/omp
  wrapProgram $out/bin/omp --prefix PATH : ${lib.makeBinPath [ pkgs.ripgrep pkgs.fd pkgs.git pkgs.coreutils ]}
''
