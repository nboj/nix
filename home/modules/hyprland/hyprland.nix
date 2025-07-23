{ pkgs, ... }:
{
	imports = [
		./waybar/waybar.nix
		./hyprpaper.nix
	];
	home.packages = with pkgs; [
		bibata-cursors
	];
	gtk.cursorTheme = {
		package = pkgs.bibata-cursors;
		name = "Bibata-Modern-Classic";
		size = 24;
	}; 
	wayland.windowManager.hyprland = {
		enable = true;
		package = null;
		portalPackage = null;
	};
	wayland.windowManager.hyprland.settings = {
		"$mainMod" = "ALT";

		monitor = [
			"HDMI-A-1, 2560x1440@60, 1920x0,1"
			"DVI-I-1, 1920x1080@60, 0x0,1"
		];

		"$terminal" = "kitty";
		"$fileManager" = "dolphin";
		"$menu" = "wofi --show drun";

		exec-once = [
			"waybar"
			"[workspace 2 silent] firefox"
		];

		env = [
			"HYPRCURSOR_THEME, Bibata-Modern-Classic"
			"XCURSOR_SIZE,24"
			"HYPRCURSOR_SIZE,24"
			"HYPRSHOT_DIR, Pictures/Screenshots/"
		];

		general = {
			gaps_in = 5;
			gaps_out = 20;
			border_size = 2;

			# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
			"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
			"col.inactive_border" = "rgba(595959aa)";

			# Set to true enable resizing windows by clicking and dragging on borders and gaps
			resize_on_border = false;

			# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
			allow_tearing = false;
			layout = "dwindle";
		};


		# https://wiki.hyprland.org/Configuring/Variables/#decoration
		decoration =  {
			rounding = 10;
			rounding_power = 2;

			# Change transparency of focused and unfocused windows
			active_opacity = 1.0;
			inactive_opacity = 1.0;

			shadow = {
				enabled = true;
				range = 4;
				render_power = 3;
				color = "rgba(1a1a1aee)";
			};

			# https://wiki.hyprland.org/Configuring/Variables/#blur
			blur =  {
				enabled = true;
				size = 3;
				passes = 1;

				vibrancy = 0.1696;
			};
		};

		# https://wiki.hyprland.org/Configuring/Variables/#animations
		animations = {
			enabled = "yes, please :)";

			# Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

			bezier = [
				"easeOutQuint,0.23,1,0.32,1"
				"easeInOutCubic,0.65,0.05,0.36,1"
				"linear,0,0,1,1"
				"almostLinear,0.5,0.5,0.75,1.0"
				"quick,0.15,0,0.1,1"
			];

			animation = [
				"global, 1, 10, default"
				"border, 1, 5.39, easeOutQuint"
				"windows, 1, 4.79, easeOutQuint"
				"windowsIn, 1, 4.1, easeOutQuint, popin 87%"
				"windowsOut, 1, 1.49, linear, popin 87%"
				"fadeIn, 1, 1.73, almostLinear"
				"fadeOut, 1, 1.46, almostLinear"
				"fade, 1, 3.03, quick"
				"layers, 1, 3.81, easeOutQuint"
				"layersIn, 1, 4, easeOutQuint, fade"
				"layersOut, 1, 1.5, linear, fade"
				"fadeLayersIn, 1, 1.79, almostLinear"
				"fadeLayersOut, 1, 1.39, almostLinear"
				"workspaces, 1, 1.94, almostLinear, fade"
				"workspacesIn, 1, 1.21, almostLinear, fade"
				"workspacesOut, 1, 1.94, almostLinear, fade"
			];
		};


		# Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
		# "Smart gaps" / "No gaps when only"
		# uncomment all if you wish to use that.
		# workspace = w[tv1], gapsout:0, gapsin:0
		# workspace = f[1], gapsout:0, gapsin:0
		# windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
		# windowrule = rounding 0, floating:0, onworkspace:w[tv1]
		# windowrule = bordersize 0, floating:0, onworkspace:f[1]
		# windowrule = rounding 0, floating:0, onworkspace:f[1]

		# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		dwindle = {
			pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
			preserve_split = true; # You probably want this
		};

		# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		master = {
			new_status = "master";
		};

		# https://wiki.hyprland.org/Configuring/Variables/#misc
		misc = {
			force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
			disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
		};


		#############
		### INPUT ###
		#############

		# https://wiki.hyprland.org/Configuring/Variables/#input
		input = {
			kb_layout = "us";
			kb_variant = "colemak_dh";
			#kb_model =
			kb_options = "caps:escape";
			#kb_rules =

			follow_mouse = 1;

			sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

			touchpad = {
				natural_scroll = false;
			};
		};

		# https://wiki.hyprland.org/Configuring/Variables/#gestures
		gestures = {
			workspace_swipe = false;
		};

		# Example per-device config
		# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
		device = {
			name = "epic-mouse-v1";
			sensitivity = -0.5;
		};

		# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
		bind =
			[
				"$mainMod, Q, exec, $terminal"
				"$mainMod, C, killactive,"
				"$mainMod, M, exit,"
				"$mainMod, F, exec, $fileManager"
				"$mainMod, V, togglefloating,"
				"$mainMod, SPACE, exec, $menu"
				"$mainMod, P, pseudo," # dwindle
				"$mainMod, S, togglesplit," # dwindle
				# Move focus with mainMod + arrow keys
				"$mainMod, H, movefocus, l"
				"$mainMod, L, movefocus, r"
				"$mainMod, K, movefocus, u"
				"$mainMod, J, movefocus, d"
				# Example special workspace (scratchpad)
				"$mainMod, E, togglespecialworkspace, magic"
				"$mainMod SHIFT, E, movetoworkspace, special:magic"
				"$mainMod SHIFT, S, exec, hyprshot -m region"

				"$mainMod SHIFT, H, movewindow, l"
				"$mainMod SHIFT, L, movewindow, r"
				"$mainMod SHIFT, K, movewindow, u"
				"$mainMod SHIFT, J, movewindow, d"
			]
			++ (
				# workspaces
				# binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
				builtins.concatLists (builtins.genList (i:
					let ws = i + 1;
					in [
						"$mainMod, code:1${toString i}, workspace, ${toString ws}"
						"$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
					]
				)
					10)
			);
		# Move/resize windows with mainMod + LMB/RMB and dragging
		bindm = [
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
		];

		# Laptop multimedia keys for volume and LCD brightness
		bindel = [
			",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
			",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
			",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
			",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
			",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
		];

		# Requires playerctl
		bindl = [
			", XF86AudioNext, exec, playerctl next"
			", XF86AudioPause, exec, playerctl play-pause"
			", XF86AudioPlay, exec, playerctl play-pause"
			", XF86AudioPrev, exec, playerctl previous"
		];
		windowrule = [
			# Ignore maximize requests from apps. You'll probably like this.
			"suppressevent maximize, class:.*"
			# Fix some dragging issues with XWayland
			"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
		];
	};


	# xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
	# xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
}
