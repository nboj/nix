let
  nix_path = "~/.nix";
in
{ ... }:

{
  imports = [
    ../zsh.nix
  ];
  # Dotfiles / programs you want configured
  programs.zsh.shellAliases.rebuild = "sudo nixos-rebuild switch --flake ${nix_path}#odin";
}

