# TODO: Support multiple firefox profiles. Currently the "default" profile is
#       assumed
{
  lib,
  config,
  ...
}:
{
  options.programs.firefox.mutableAndReproducibleSettings = lib.mkEnableOption "mutable and reproducible file handling for the settings";
  config = lib.mkIf config.programs.firefox.mutableAndReproducibleSettings {
    home.file."${config.programs.firefox.configPath}/default/user.js" = {
      mutableAndReproducible = true;
      force = true;
    };
  };
}
