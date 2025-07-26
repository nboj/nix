{pkgs, ...}:
{
	# home/cauman.nix  (or any HM module)
	services.mako = {
		enable = true;
		settings = {
			font            = "JetBrainsMono Nerd Font 12";
			background-color = "#1e1e2e";
			text-color       = "#cdd6f4";
			border-size      = 2;
			border-color     = "#585b70";
			default-timeout  = 5000;   # ms
			layer = "overlay";
		};
	};

	home.packages = with pkgs; [
		libnotify
	];
}
