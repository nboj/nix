# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
	imports = [
		../modules/nvidia.nix
		../modules/configuration.nix
		#./modules/passthrough.nix
	];
	networking.hostName = "odin"; # Define your hostname.
}

