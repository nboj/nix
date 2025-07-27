{ pkgs, ... }:
{
  imports = [
    ../hyprland/waybar/waybar.nix
    ../hyprland/hyprpaper.nix
    ../hyprland/hyprland.nix
  ];
}
