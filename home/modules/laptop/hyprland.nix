{ pkgs, ... }:
{
  imports = [
    ../hyprland/waybar/waybar.nix
    ../hyprland/hyprpaper.nix
    ../hyprland/hyprland.nix
  ];

  wayland.windowManager.hyprland.settings.monitor = [
      "eDP-1, 2560x1600@240, 1920x0,1.25"
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "[workspace 1 silent] firefox"
    "[workspace 10 silent] thunderbird"
  ];
}
