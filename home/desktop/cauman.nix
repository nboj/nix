# NOTE: MUST RUN THIS FIRST nix run github:KaylorBen/nixcord#dorion

{ config, pkgs, ... }:

{
  imports = [
    ../cauman.nix
    ../modules/desktop/hyprland.nix
    ../modules/desktop/zsh.nix
  ];
}

