# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
	imports = [
		# Include the results of the hardware scan.
		./modules/hyprland.nix
		#./modules/nvidia.nix
		./modules/passthrough.nix
		./modules/kernel-remap.nix
		./modules/thunar.nix
	];
	boot.kernelPackages = pkgs.linuxPackages_zen;

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.cauman = {
		isNormalUser = true;
		description = "Christian";
		extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
		# packages = with pkgs; [];
		shell = pkgs.zsh;
	};

	services.getty.autologinOnce = true;
	services.getty.autologinUser = "cauman"; # your username


	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;


	console.keyMap = "mod-dh-iso-us";

	# spotify
	networking.firewall.allowedTCPPorts = [ 57621 ];
	networking.firewall.allowedUDPPorts = [ 5353 ];

	# bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
	};
	services.blueman.enable = true;

	# rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true; # if not already enabled
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment the following
		#jack.enable = true;
	};


	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?
	programs.zsh.enable = true;

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
		kitty
		firefox
		gh
		unzip
		tree
		pavucontrol
		spotify
		kbd
		evtest
		awscli2
		gnome-system-monitor
		wget

		# ---- WINE ----
		wineWowPackages.stable # support both 32-bit and 64-bit applications
		wine # support 32-bit only
		(wine.override { wineBuild = "wine64"; }) # support 64-bit only
		wine64 # support 64-bit only
		wineWowPackages.staging # wine-staging (version with experimental features)
		winetricks # winetricks (all versions)
		wineWowPackages.waylandFull # native wayland support (unstable)
	];

	programs.tmux = {
		enable = true;
		extraConfig = ''
			set -g base-index 1
			set -sg escape-time 0
		'';
	};
}

