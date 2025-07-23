let 
	nix_path = "~/.nix";
in
{ ... }:

{
	# Dotfiles / programs you want configured
	programs.zsh = {
		enable = true;
		shellAliases = {
			ll = "ls -la";
			vim = "nvim";
			rebuild = "sudo nixos-rebuild switch --flake ${nix_path}#cauman";
			nixos = "cd ${nix_path}/ && vim .";
			restartwaybar = "pkill waybar 2>/dev/null; waybar & disown";
		};
	};
}

