# NOTE: MUST RUN THIS FIRST nix run github:KaylorBen/nixcord#dorion

{ config, pkgs, ... }:

{
  imports = [
    ../cauman.nix
    ../modules/laptop/hyprland.nix
    ../modules/laptop/zsh.nix
  ];
}

