{
  lib,
  config,
  ...
}:
{
  options.programs.zed-editor = {
    mutableAndReproducibleUserDebug = lib.mkEnableOption "mutable and reproducible file handling for the user debug configs";
    mutableAndReproducibleUserKeymaps = lib.mkEnableOption "mutable and reproducible file handling for the the user keymaps";
    mutableAndReproducibleUserSettings = lib.mkEnableOption "mutable and reproducible file handling for the user settings";
    mutableAndReproducibleUserTasks = lib.mkEnableOption "mutable and reproducible file handling for the user tasks";
  };

  # Note: The zed-editor module itself provides a mechanism for managing
  # mutable debug/keymaps/settings/tasks which would result in conflicts, if
  # not disabled.
  config = lib.mkMerge [
    (lib.mkIf config.programs.zed-editor.mutableAndReproducibleUserDebug {
      xdg.configFile."zed/debug.json" = {
        mutableAndReproducible = true;
        force = true;
      };
      programs.zed-editor = {
        mutableUserDebug = false;
      };
    })
    (lib.mkIf config.programs.zed-editor.mutableAndReproducibleUserKeymaps {
      xdg.configFile."zed/keymap.json" = {
        mutableAndReproducible = true;
        force = true;
      };
      programs.zed-editor = {
        mutableUserKeymaps = false;
      };
    })
    (lib.mkIf config.programs.zed-editor.mutableAndReproducibleUserSettings {
      xdg.configFile."zed/settings.json" = {
        mutableAndReproducible = true;
        force = true;
      };
      programs.zed-editor = {
        mutableUserSettings = false;
      };
    })
    (lib.mkIf config.programs.zed-editor.mutableAndReproducibleUserTasks {
      xdg.configFile."zed/tasks.json" = {
        mutableAndReproducible = true;
        force = true;
      };
      programs.zed-editor = {
        mutableUserTasks = false;
      };
    })
  ];
}
