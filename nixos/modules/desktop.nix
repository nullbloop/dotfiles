{ pkgs, lib, ... }:

{
  # 1. Login Manager
  services.displayManager.ly.enable = true;

  # 2. Audio (PipeWire + WirePlumber)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # 3. Security & Keyring
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # 4. Input
  services.libinput.enable = true;

  # 5. Yazi File Chooser Portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-termfilechooser
    ];

    config = {
      common = {
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
  };

  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text =
    let
      yaziDeps = pkgs.buildEnv {
        name = "yazi-portal-deps";
        paths = with pkgs; [
          yazi
          gnused
          bashInteractive
        ];
      };
    in
    ''
      [filechooser]
      env=PATH=${yaziDeps}/bin:/run/current-system/sw/bin
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      default_dir=$HOME
      env=TERMCMD=${pkgs.kitty}/bin/kitty -T "filechooser" -e
      open_mode=suggested
      save_mode=last
    '';

  # 6. Manually create the .desktop entry for Yazi
  environment.etc."xdg/applications/yazi.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Yazi
    Comment=Blazing fast terminal file manager
    Exec=kitty -e yazi %u
    Terminal=false
    MimeType=inode/directory;
    Categories=Utility;FileManager;
  '';

  # 7. MIME Associations (Zen Browser & Yazi)
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = lib.mkForce "zen-beta.desktop";
    "x-scheme-handler/http" = lib.mkForce "zen-beta.desktop";
    "x-scheme-handler/https" = lib.mkForce "zen-beta.desktop";
    "x-scheme-handler/about" = lib.mkForce "zen-beta.desktop";
    "x-scheme-handler/unknown" = lib.mkForce "zen-beta.desktop";
    "inode/directory" = "yazi.desktop";
  };

  # 8. Dark Mode Force (GTK & Qt)
  environment.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # 9. Ensure Yazi is available system-wide
  environment.systemPackages = with pkgs; [ yazi ];
}
