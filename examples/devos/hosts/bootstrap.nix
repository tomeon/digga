{ profiles, ... }:
{
  # build (from within a devshell) with:
  #
  #   nixos-generate --format bootstrap-iso --flake '.#bootstrap'
  #
  # or:
  #
  #   bootstrap-iso build bootstrap
  #
  # which does the same thing.
  #
  # reachable on the local link via ssh root@fe80::47%eno1
  # where 'eno1' is replaced by your own machine's network
  # interface that has the local link to the target machine
  imports = [
    # profiles.networking
    profiles.core
    profiles.users.root # make sure to configure ssh keys
    profiles.users.nixos
  ];

  boot.loader.systemd-boot.enable = true;

  # will be overridden by the bootstrap-iso `nixos-generate` format profile
  # defined by the digga "nixos-generators" devshell module
  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
