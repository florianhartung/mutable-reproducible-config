{
  lib,
  config,
  ...
}:
let
  modulePath = [
    "programs"
    "gram"
  ];
  cfg = lib.getAttrFromPath modulePath config;
in
{
  options = lib.setAttrByPath modulePath {
    mutableAndReproducibleConfigs = lib.mkEnableOption "mutable and reproducible file handling for all configurations";
    mutableAndReproducibleSettings = lib.mkEnableOption "mutable and reproducible file handling for the settings";
    mutableAndReproducibleKeymap = lib.mkEnableOption "mutable and reproducible file handling for the keymap";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.mutableAndReproducibleSettings || cfg.mutableAndReproducibleConfigs) {
      xdg.configFile."gram/settings.jsonc" = {
        mutableAndReproducible = true;
        force = true;
      };
    })
    (lib.mkIf (cfg.mutableAndReproducibleKeymap || cfg.mutableAndReproducibleConfigs) {
      xdg.configFile."gram/keymap.jsonc" = {
        mutableAndReproducible = true;
        force = true;
      };
    })
  ];
}
