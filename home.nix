{ config, pkgs, lib, ...}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isx86_64 = pkgs.stdenv.hostPlatform.isx86_64;
  unsupported = builtins.abort("Unsupported platform");
in 
{
	imports = [
		# TODO: import home info from imports
	];

	home.username = "ryan";
	home.homeDirectory = 
		if isLinux then "/home/ryan" else
		if isDarwin then "/Users/ryan/" else
		unsupported;

	home.stateVersion = "23.11"; # Don't touch
	programs.home-manager.enable = true;
	programs.bash = {
		enable = false;
		shellAliases = {
			nix-diff = "nix profile diff-closures --profile \"$HOME/.local/state/nix/profiles/home-manager\"";
			nix-update = "sudo nix-channel --update && home-manager switch && nix-diff";
		};
	};

	home.packages = with pkgs; ([
		# Common packages
		bat
		fzf
		git
		jq
		lsd
		luajit
		neofetch
		neovim
		protobuf
		ripgrep
		starship
		tmux
		xsv
	] ++ lib.optionals isLinux [
		# Linux only packages
		wezterm # doesn't compile on intel macOS right now...
	] ++ lib.optionals isDarwin [
		# MacOs only packages
		openssl
		pv
		wget
	]);
}
