final: prev: {
  kakoune = prev.kakoune.override {
    configure.plugins = with final.kakounePlugins; [
      kak-fzf
      kak-auto-pairs
      kak-buffers
      (kak-powerline.overrideAttrs
        (self:
          let src = prev.srcs.kak-powerline;
          in { inherit src; inherit (src) version; })
      )
      kak-vertical-selection
    ];
  };

  fzf = prev.skim;

  # wrapper to specify config dir
  kakoune-config = prev.writeShellScriptBin "k" ''
    KAKOUNE_CONFIG_HOME=/etc/xdg/kak exec ${final.kakoune}/bin/kak "$@"
  '';
}
