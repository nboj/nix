{ config, pkgs, ... }:

{
	imports = [
		./modules/hyprland/hyprland.nix
		./modules/zsh.nix
		./modules/theme.nix
		./modules/notification.nix
		./modules/looking-glass.nix
	];
	home.username = "cauman";
	home.homeDirectory = "/home/cauman";
	home.stateVersion = "25.05"; # Match your NixOS version

	programs.git = {
		enable = true;
		userName = "nboj";
		userEmail = "bud@example.com";
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	programs.starship.enable = true;


	# --- OTHER ---
	# Packages available in your user profile only (not system-wide)
	home.packages = with pkgs; [
		ripgrep
		gcc
		rustup
		python3
		discord
		nodejs
		fastfetch
	];

	# Let Home Manager manage ~/.config directories cleanly
	xdg.enable = true;
}

