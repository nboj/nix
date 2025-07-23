{ ... }:
{
	services.hyprpaper = {
		enable = true;
		settings = {
			ipc = "off";
			splash = false;
			preload = [
				"~/Pictures/wallpaper.jpeg"
			];
			wallpaper = [
				", ~/Pictures/wallpaper.jpeg"
			];
		};
	};
}
