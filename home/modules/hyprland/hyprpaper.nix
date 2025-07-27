{ config, ... }:

let
  wallpaper = ./wallpaper.jpeg;  # Path relative to your flake or config file
in {
  xdg.configFile."hypr/wallpaper.jpeg".source = wallpaper;

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "${config.xdg.configHome}/hypr/wallpaper.jpeg"
      ];
      wallpaper = [
        ", ${config.xdg.configHome}/hypr/wallpaper.jpeg"
      ];
    };
  };
}
