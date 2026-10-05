{
  lib,
  config,
  ...
}:
{
  options.programs.alacritty.mutableAndReproducibleConfig = lib.mkEnableOption "mutable and reproducible config file handling";
  config = lib.mkIf config.programs.alacritty.mutableAndReproducibleConfig {
    xdg.configFile."alacritty/alacritty.toml" = {
      mutableAndReproducible = true;
      force = true;
    };
  };
}
