{...}:
{
	programs.looking-glass-client = {
		enable = true;               # pulls in looking‑glass‑client B7
		settings = {
			input = {
				escapeKey = "KEY_F12";
			};
			app = {             # ~/.config/looking-glass-client.ini
				fullScreen = "no";
				shmFile    = "/dev/kvmfr0";
			};
		};
	};                                                   
}
