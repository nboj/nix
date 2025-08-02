# NOTE: MUST RUN THIS FIRST nix run github:KaylorBen/nixcord#dorion

{ config, pkgs, ... }:

{
  imports = [
    ./modules/theme.nix
    ./modules/notification.nix
    ./modules/looking-glass.nix
    ./modules/thunderbird.nix
    ./modules/obs.nix
    ./modules/wofi.nix
    #./modules/nixcord.nix
  ];
  home.username = "cauman";
  home.homeDirectory = "/home/cauman";
  home.stateVersion = "25.05"; # Match your NixOS version

  programs.git = {
    enable = true;
    userName = "nboj";
    userEmail = "bud@example.com";
    extraConfig = {
      credential."https://github.com".helper = "!gh auth git-credential";

      # (Optional) A nice‑to‑have that `gh` normally sets itself:
      gh."github.com".user = "nboj";
    };
    includes = [
      { path = "~/.gitlocal"; condition = "true"; }
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.starship.enable = true;

  # --- OTHER ---
  # Packages available in your user profile only (not system-wide)
  home.packages = with pkgs; [
    ripgrep
    gcc
    python3
		#discord
    nodejs
    fastfetch
    dbeaver-bin
    protonvpn-gui
    # minecraft
    prismlauncher

    # rust
    clippy
    rustfmt
    rust-analyzer

		todoist-electron
		globalprotect-openconnect
		sirikali
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  # Let Home Manager manage ~/.config directories cleanly
  xdg.enable = true;
}

