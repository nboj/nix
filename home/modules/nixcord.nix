{...}:
{
	programs.nixcord = {
		enable = true;
		#discord.enable = true;
		vesktop.enable = true;
		dorion.enable = true;
		config = {
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
			};
		};
		# NOTE: MUST RUN THIS FIRST nix run github:KaylorBen/nixcord#dorion
		dorion = {
		  theme = "dark";
		  blur = "acrylic";       # "none", "blur", or "acrylic"
			#autoClearCache = true;
		  disableHardwareAccel = false;
		  rpcServer = true;
		  rpcProcessScanner = true;
		  pushToTalk = true;
		  pushToTalkKeys = ["RControl"];
		  desktopNotifications = true;
		  unreadBadge = true;
		};
	};
	xdg.desktopEntries.dorion = {
	  name = "Discord (Dorion)";
	  comment = "Lightweight Discord client";
	  exec = "dorion";
	  icon = "discord"; # or use a custom icon path
	  terminal = false;
	  type = "Application";
	  categories = [ "Network" "InstantMessaging" ];
	  genericName = "Discord";
	};
}
