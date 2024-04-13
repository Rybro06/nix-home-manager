{
	description = "Home manager configuration";

	inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

	inputs.home-manager = {
		url = "github:nix-community/home-manager/master";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager }: {
		homeConfigurations = {
			"ryan@pop-OS" = home-manager.lib.homeManagerConfiguration ({
				modules = [ (import ./home.nix) ];
				pkgs = import nixpkgs {
					system = "x86_64-linux";
				};
			});

			"ryan@Ryans-MBP" = home-manager.lib.homeManagerConfiguration ({
				modules = [ (import ./home.nix) ];
				pkgs = import nixpkgs {
					system = "x86_64-darwin";
				};
			});
			
			"ryan@Ryans-MacBook-Pro.local" = home-manager.lib.homeManagerConfiguration ({
				modules = [ (import ./home.nix) ];
				pkgs = import nixpkgs {
					system = "x86_64-darwin";
				};
			});
		};
	};
}
