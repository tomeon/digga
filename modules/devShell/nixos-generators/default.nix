{ config, lib, pkgs, ... }:

let
  cfg = config.digga.nixos-generators;

  searchPathVar = "NIXOS_GENERATORS_FORMAT_SEARCH_PATH";

  bootstrap-iso = {
    category = "devos";
    name = "bootstrap-iso";
    help = "Create and burn a bootstrap ISO for the specified NixOS configuration";
    command = builtins.readFile ./bootstrap-iso;
  };
in
{
  options.digga.nixos-generators =
    let
      inherit (lib) mkOption mkEnableOption types;
    in
    {
      enable = mkEnableOption "nixos-generators extensions";

      category = mkOption {
        type = types.str;
        default = "generators";
        description = "category for the nixos-generate and bootstrap-iso commands";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.nixos-generators;
        description = "package providing nixos-generators";
      };
    };

  config = lib.mkIf cfg.enable {
    commands = [
      { inherit (cfg) category package; }
      bootstrap-iso
    ];

    env = [
      {
        name = searchPathVar;

        # prepend our formats directory to the nixos-generate search path
        eval = ''
          ''${${searchPathVar}:+''${${searchPathVar}}:}${toString ./formats}
        '';
      }
    ];
  };
}
