{pkgs, ...}:
{
	services.arrpc = {
		enable = false;
	};
	programs.nixcord = {
		enable = false;
		discord.enable = true;
		vesktop.enable = false;
		dorion.enable = false;
		config = {
			frameless = true;
			plugins = {
				ctrlEnterSend = {
					enable = true;
				};
				gameActivityToggle = {
					enable = true;
				};
				messageLinkEmbeds = {
					enable = true;
				};
				serverInfo.enable = true;
				showHiddenChannels.enable = true;
				silentTyping.enable = true;
				silentMessageToggle.enable = true;
				youtubeAdblock.enable = true;
				webRichPresence.enable = true;
			};
		};
		# NOTE: MUST RUN THIS FIRST nix run github:KaylorBen/nixcord#dorion
		dorion = {
		  theme = "dark";
		  blur = "acrylic";       # "none", "blur", or "acrylic"
		  autoClearCache = true;
		  disableHardwareAccel = false;
		  rpcServer = true;
		  rpcProcessScanner = true;
		  pushToTalk = true;
		  pushToTalkKeys = ["RControl"];
		  desktopNotifications = true;
		  unreadBadge = true;
		};

	};
	#xdg.desktopEntries.dorion = {
	#  name = "Discord (Dorion)";
	#  comment = "Lightweight Discord client";
	#  exec = "dorion";
	#  icon = "discord"; # or use a custom icon path
	#  terminal = false;
	#  type = "Application";
	#  categories = [ "Network" "InstantMessaging" ];
	#  genericName = "Discord";
	#};

	#xdg.configFile."dorion/RegisteredGames.json".text = builtins.toJSON [
	#  {
	#    name = "Neovim";
	#    process = "nvim";
	#    details = "Editing config.nix";
	#    state = "In tmux";
	#  }
	#  {
	#    name = "tmux";
	#    process = "tmux";
	#    details = "Terminal multiplexing";
	#    state = "Tracking sessions";
	#  }
	#  {
	#    name = "Firefox";
	#    process = "firefox";
	#    details = "Browsing the web";
	#    state = "Probably reading docs";
	#  }
	#];
}
