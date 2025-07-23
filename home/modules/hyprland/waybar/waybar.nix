{ pkgs, ... }:
{
	home.packages = with pkgs; [
		bluetui
		bluez
		brightnessctl
		rofi-wayland
		nerd-fonts.jetbrains-mono
		wireplumber
		lm_sensors
		playerctl
		libnotify
	];
	xdg.configFile."waybar".source = ./waybar;
	xdg.configFile."waybar".recursive = true;
	xdg.configFile."rofi".source = ./waybar/rofi;
	xdg.configFile."rofi".recursive = true;
}
#let
#  colors = import ./colors.nix;
#  gapsOut = config.wayland.windowManager.hyprland.settings.general.gaps_out;
#  gapsIn = config.wayland.windowManager.hyprland.settings.general.gaps_in;
#  borderRadius = config.wayland.windowManager.hyprland.settings.decoration.rounding;
#  borderSize = config.wayland.windowManager.hyprland.settings.general.border_size;
#  shadowRange = config.wayland.windowManager.hyprland.settings.decoration.shadow.range;
#in
#{
#  home.packages = with pkgs; [
#  	playerctl
#  	cava
#  ];
#
#  programs.waybar = {
#    enable = true;
#    settings = {
#      mainBar = {
#        position = "top";
#        height = 30;
#        spacing = gapsOut;
#        margin-left = gapsOut;
#        margin-right = gapsOut;
#        margin-top = gapsOut;
#        
#        modules-left = [ "hyprland/workspaces" "mpris" "cava" "cava#mic" ];
#        modules-center = [ "hyprland/window" ];
#        modules-right = [ "cpu" "memory" "wireplumber" "clock" ];
#        
#        "hyprland/workspaces" = {
#          disable-scroll = true;
#          all-outputs = true;
#          hide-active = false;
#          format = "{icon}";
#          format-icons = {
#            "1" = "1";
#            "2" = "2";
#            "3" = "3";
#            "4" = "4";
#            "5" = "5";
#            "6" = "6";
#            "7" = "7";
#            "8" = "8";
#            "9" = "9";
#            "10" = "10";
#            default = "";
#          };
#        };
#        
#        "hyprland/window" = {
#          format = "{}";
#          max-length = 50;
#          separate-outputs = true;
#        };
#
#        "mpris" = {
#          format = "{title} - {artist}";
#        };
#
#        "cava" = {
#          framerate = 48;
#          bars = 14;
#          method = "pipewire";
#          stereo = true;
#          bar_delimiter = 0;
#          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
#        };
#
#        "cava#mic" = {
#          framerate = 48;
#          bars = 7;
#          method = "pipewire";
#          source = "alsa_input.usb-Focusrite_Scarlett_2i2_4th_Gen_S2QHWME47A255E-00.analog-surround-40";
#          stereo = false;
#          bar_delimiter = 0;
#          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
#        };
#
#       "clock" = {
#          format = "{:%Y-%m-%d %H:%M:%S}";
#          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
#          format-alt = "{:%Y-%m-%d}";
#        };
#
#        "memory" = {
#          interval = "1";
#          format = "RAM {}%";
#          max-length = 10;
#        };
#
#        "cpu" = {
#          interval = "1";
#          format = "CPU {}%";
#          max-length = 10;
#        };
#
#        "wireplumber" = {
#          format = "VOL {volume}%";
#          format-muted = "";
#          on-click = "pwvucontrol";
#          max-volume = 100;
#          scroll-step = 0.2; 
#        };
#        
#      };
#    };
#    
#    style = ''
#      * {
#      	background-color: transparent;
#        font-family: "Play";
#        font-size: 16px;
#        min-height: 0;
#      }
#      
#      window#waybar {
#        color: ${colors.text};
#      }
#      
#      #workspaces {
#      	background-color: ${colors.base};
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      }
#
#      #mpris {
#      	background-color: ${colors.base};
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	padding: 0 ${toString gapsOut}px;
#      }
#
#      #cava {
#      	background-color: ${colors.base};
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	padding: 0 ${toString gapsOut}px;
#      }
#
#      #memory {
#      	background-color: ${colors.base};
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	padding: 0 ${toString gapsOut}px;
#      }
#
#      #cpu {
#      	background-color: ${colors.base};
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	padding: 0 ${toString gapsOut}px;
#      }
#
#
#      #wireplumber {
#      	background-color: ${colors.base};
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	padding: 0 ${toString gapsOut}px;
#      }
#
#
#      #mpris.paused {
#      	border: ${toString borderSize}px solid ${colors.surface2};
#      	border-radius: ${toString borderRadius}px;
#      }
#      
#      #workspaces button {
#        padding: 0 ${toString gapsOut}px;
#        color: ${colors.text};
#        background-color: transparent;
#        border: ${toString borderSize}px solid transparent;
#        border-radius: ${toString borderRadius}px;
#      }
#      
#      
#	  #workspaces button.active {
#	    color: ${colors.text};
#	    text-decoration: underline;
#	    text-decoration-color: ${colors.text};
#	  }
#
#	  #workspaces button:hover {
#	    box-shadow: none; /* Remove predefined box-shadow */
#	    text-shadow: none; /* Remove predefined text-shadow */
#	    background: none; /* Remove predefined background color (white) */
#	    transition: none; /* Disable predefined animations */
#	    border: ${toString borderSize}px solid ${colors.surface2};
#	    border-radius: ${toString borderRadius}px;
#	  }
#      
#      #window {
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	background-color: ${colors.base};
#        padding: 0 ${toString gapsOut}px;
#        color: ${colors.text};
#      }
#      
#      #clock {
#      	border: ${toString borderSize}px solid ${colors.base};
#      	border-radius: ${toString borderRadius}px;
#      	background-color: ${colors.base};
#        padding: 0 ${toString gapsOut}px;
#        color: ${colors.text};
#      }
#    '';
#  };
#}
