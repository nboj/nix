# flake.nix
{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager.url = "github:nix-community/home-manager/release-25.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = { self, nixpkgs, home-manager, hyprland, ... } @inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
		in {
			home-manager.backupFileExtension = "backup";
			nixosConfigurations.cauman = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					./configuration.nix
					./hardware-configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.cauman = import ./home/cauman.nix;
					}
					{
						nix.settings = {
							substituters = ["https://hyprland.cachix.org"];
							trusted-substituters = ["https://hyprland.cachix.org"];
							trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
							trusted-users = ["root" "cauman"];
						};
					}

				];
				specialArgs = {
					inherit inputs;
				};
			};
		};
}

