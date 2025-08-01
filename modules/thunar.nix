{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
	plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
	];
  };
  programs.xfconf.enable = true;

  services.tumbler.enable = true;
  services.gvfs.enable = true;
  environment.systemPackages = with pkgs; [
    imv
    vlc
  ];
}
