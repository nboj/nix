{ pkgs, ... }:
{
  # Don't use `services.udev.extraHwdb`, it does not create the file at least in NixOS 24.05
  # See https://github.com/NixOS/nixpkgs/issues/182966 for detail
  #
  # - Specify hardware names even if `evdev:input:*` working for mostcase. I should care both US and JIS layout
  # - How to get the KEYBOARD_KEY_700??: `showkey --scancodes` in VT
  # - How to get the hardware name:: `udevadm info --attribute-walk /dev/input/event?? | grep -F 'ATTRS{name}'`
  # - How to apply?: After nixos-rebuild switch `sudo systemd-hwdb update && sudo udevadm trigger`
  environment.etc."udev/hwdb.d/99-local.hwdb".text = ''
evdev:input:b*v*p*
 KEYBOARD_KEY_70039=esc 
  '';
  system.activationScripts.hwdbUpdate = {
    text = ''
		echo Updating hwdb...
		${pkgs.systemd}/bin/systemd-hwdb update
		${pkgs.systemd}/bin/udevadm trigger
	'';
  };
}
