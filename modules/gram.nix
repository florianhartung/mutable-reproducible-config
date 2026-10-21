{
  lib,
  config,
  ...
}:
{
  options.programs.gram = {
    mutableAndReproducibleSettings = lib.mkEnableOption "mutable and reproducible file handling for the settings";
  };

  config = lib.mkIf config.programs.gram.mutableAndReproducibleSettings {
    xdg.configFile."gram/settings.jsonc" = {
      mutableAndReproducible = true;
      force = true;
    };
  };
}
