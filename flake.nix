{
  description = "My minimal Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ...  }: 


    let
	    system = "x86_64-linux";
            pkgs = import nixpkgs {
	    inherit system;
	    config.allowUnfree = true;
            };

            lib = nixpkgs.lib;
    in {
	    nixosConfigurations = {
		    moaaz = lib.nixosSystem {
			    inherit system;
			    modules = [ ./configuration.nix
				    home-manager.nixosModules.home-manager {
					    home-manager.useGlobalPkgs = true;
					    home-manager.useUserPackages = true;
					    home-manager.users.moaaz = {
						    imports = [ ./home.nix ];
					    };
				    } ];
		    };
#<second user> = lib.nixosSystem {
#inherit system;
#modules = [ ./configuration.nix ];
#};
	    };
  };
}
