{ self, inputs, ... }:
{
  modules = with inputs; [
    bud.devshellModules.bud
    digga.devshellModules.nixos-generators
  ];
  exportedModules = [
    ./devos.nix
  ];
}

