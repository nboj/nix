{ pkgs, ... }:
{
# Make GTK prefer dark, and set the GNOME interface key
gtk = {
  enable = true;
  theme.name = "Adwaita-dark";
  iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };
  gtk3.extraConfig."gtk-application-prefer-dark-theme" = 1;
  gtk4.extraConfig.Settings = ''
    gtk-application-prefer-dark-theme=1
  '';
};

	# Optional: better GTK3 look that matches libadwaita
	dconf.settings."org/gnome/desktop/interface" = {
		color-scheme = "prefer-dark";
		gtk-theme = "Adwaita-dark";
		icon-theme = "Papirus-Dark";
};

	home.sessionVariables = {
		GTK_THEME = "Adwaita-dark";
	};
	home.packages = with pkgs; [
		gnome-themes-extra
pkgs.adw-gtk3
	];
}
