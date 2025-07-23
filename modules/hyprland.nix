{config, pkgs, inputs, ... }:
{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
		withUWSM = true;
		# set the flake package
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		# make sure to also set the portal package, so that they are in sync
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		displayManager.gdm.wayland = true;
		xkb.layout = "us";
		xkb.variant = "colemak_dh_iso";
	};
	services.displayManager.autoLogin = {
		enable = true;
		user = "cauman";
	};
	environment.systemPackages = with pkgs; [
		hyprpaper
		waybar
		wofi
		wl-clipboard
		hyprshot
	];
	xdg.portal = {
		enable = true;                                   # pulls in xdg-desktop-portal
		extraPortals = [                                 # make *one* implementation win
			inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
		];
	};
}
