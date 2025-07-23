{ pkgs, ... }:
{
	gtk = {
		enable = true;
		theme = {
			name = "Adwaita-dark";
		};
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
	};

	home.sessionVariables = {
		GTK_THEME = "Adwaita-dark";
	};
	home.packages = with pkgs; [
		gnome-themes-extra
	];
}
