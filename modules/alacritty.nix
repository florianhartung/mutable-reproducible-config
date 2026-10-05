{
  lib,
  config,
  ...
}:
{
  options.programs.alacritty.mutableAndReproducibleSettings = lib.mkEnableOption "mutable and reproducible config file handling for the settings";
  config = lib.mkIf config.programs.alacritty.mutableAndReproducibleSettings {
    xdg.configFile."alacritty/alacritty.toml" = {
      mutableAndReproducible = true;
      force = true;
    };
  };
}
