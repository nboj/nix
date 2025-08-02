{ config, pkgs, ... }:

let
  gapsOut = config.wayland.windowManager.hyprland.settings.general.gaps_out;
  gapsIn = config.wayland.windowManager.hyprland.settings.general.gaps_in;
in
{
  programs.wofi = {
    enable = true;

    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 20;
      gtk_dark = true;
      hide_scroll = true;
      layer = "overlay";
      hide_on_focus_out = true;
    };

    style = ''
      * {
        font-family: "Play";
        font-size: 16px;
      }

      window {
        margin: 0px;
        border: none;
        border-radius: 10px;
      }

      #input {
        margin: ${toString gapsIn}px;
        padding: ${toString gapsIn}px;
        border: none;
        border-radius: 8px;
        background-color: transparent;
        font-size: 16px;
      }

      #inner-box {
        margin: 0px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 0px;
        border: none;
        background-color: transparent;
      }

      #scroll {
        margin: 0px;
        border: none;
        background-color: transparent;
      }

      #text {
        margin: ${toString gapsIn}px;
        border: none;
        background-color: transparent;
      }

      #entry {
        margin: ${toString gapsIn}px;
        padding: ${toString gapsIn}px;
        border: none;
        border-radius: 6px;
        background-color: transparent;
      }

    '';
  };

  # Install the Play font from Google Fonts
  home.packages = with pkgs; [
    (google-fonts.override { fonts = [ "Play" ]; })
  ];
}
