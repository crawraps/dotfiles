# nixpkgs voxtype with onnx omits oniguruma (onig_sys via tokenizers) and sqlite, both linked from the system
{ pkgs }:

(pkgs.voxtype.override { onnxSupport = true; }).overrideAttrs (old: {
  buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.oniguruma pkgs.sqlite ];
})
