{ pkgs, ... }:

{
  # 1. Add the portal backend and ensure Yazi & its dependencies are available
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-termfilechooser
    ];

    # 2. Configure the FileChooser to use termfilechooser
    config = {
      common = {
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
  };

  # 3. Create the config file that tells termfilechooser to use Yazi
  #    We use a small wrapped environment to ensure Yazi, sed, and bash are found.
  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = let
    yaziDeps = pkgs.buildEnv {
      name = "yazi-portal-deps";
      paths = with pkgs; [ yazi gnused bashInteractive ];
    };
  in ''
    [filechooser]
    env=PATH=${yaziDeps}/bin:/run/current-system/sw/bin
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD=${pkgs.kitty}/bin/kitty -T "filechooser" -e
    open_mode=suggested
    save_mode=last
  '';

  # Ensure Yazi is available in your system packages
  environment.systemPackages = with pkgs; [ yazi ];
}
