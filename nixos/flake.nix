{
  description = "NixOS config for ASUS TUF A15 (null)";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.null = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/null/configuration.nix ];
    };
  };
}
