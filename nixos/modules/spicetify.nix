{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify-nix.nixosModules.default ];

  programs.spicetify = {
    enable = true;
    
    # You can change this to another theme, or remove it if you want default Spotify look
    theme = spicePkgs.themes.catppuccin; 
    
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
      spicyLyrics 
    ];
	enabledCustomApps = with spicePkgs.apps; [
  marketplace
];
  };
}
