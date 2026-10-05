{
  lib,
  config,
  ...
}:
{
  options.programs.zed-editor.mutableAndReproducibleUserSettings = lib.mkEnableOption "mutable and reproducible config file handling for the user settings";
  config = lib.mkIf config.programs.zed-editor.mutableAndReproducibleUserSettings {
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
