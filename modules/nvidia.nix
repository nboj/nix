{ config, pkgs, ... }:

{
  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  # Optional: For Wayland (e.g. Hyprland), enable this
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; # optional: can be true for laptops
    open = false; # true = open source kernel module (experimental)
    nvidiaSettings = true; # provides nvidia-settings GUI
  };

  # Optional: Enable full OpenGL/Vulkan support
  hardware.graphics = {
    enable = true;
  };
}
