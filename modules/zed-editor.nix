{
  lib,
  config,
  ...
}:
{
  options.programs.zed-editor.mutableAndReproducibleSettings = lib.mkEnableOption "mutable and reproducible config file handling for the settings";
  config = lib.mkIf config.programs.zed-editor.mutableAndReproducibleSettings {
    xdg.configFile."zed/settings.json" = {
      mutableAndReproducible = true;
      force = true;
    };
    programs.zed-editor = {
      # The zed-editor module itself provides a mechanism for managing mutable
      # settings which would result in conflicts, if not disabled.
      mutableUserSettings = false;
    };
  };
}
