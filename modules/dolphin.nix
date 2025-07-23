{pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		kdePackages.dolphin
		gvfs
		adwaita-icon-theme
	];
}
