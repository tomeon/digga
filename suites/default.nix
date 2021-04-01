{ users, profiles, userProfiles, ... }:

{
  system = with profiles; rec {
    work = [ develop virt users.nixos users.root ];

    graphics = work ++ [ graphical ];

    mobile = graphics ++ [ laptop ];

    play = graphics ++ [
      graphical.games
      network.torrent
      misc.disable-mitigations
    ];

    goPlay = play ++ [ laptop ];
  };

  user = with userProfiles; rec {
    base = [ direnv git ];
  };
}
