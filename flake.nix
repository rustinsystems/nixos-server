{
  description = "Automated NixOS fleet install with nixos-anywhere + disko";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
  };

  outputs = { self, nixpkgs, disko, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.web4NixR210 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        ./hosts/web4NixR210/disko.nix
        ./hosts/web4NixR210/configuration.nix
        # ./hosts/web4NixR210/hardware-configuration.nix # uncomment when generated initially for first time hardware
      ];
    };
  };
}
