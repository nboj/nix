{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;
  };
  programs.xfconf.enable = true;

  services.tumbler.enable = true;
  environment.systemPackages = with pkgs; [
    gvfs
    imv
    vlc
  ];
}
