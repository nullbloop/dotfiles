{ pkgs, lib, ... }:
let
  yaziDesktop = pkgs.makeDesktopItem {
    name = "yazi";
    desktopName = "Yazi";
    comment = "Blazing fast terminal file manager";
    exec = "${pkgs.kitty}/bin/kitty -e ${pkgs.yazi}/bin/yazi %u";
    terminal = false;
    mimeTypes = [ "inode/directory" ];
    categories = [
      "Utility"
      "FileManager"
    ];
  };
in
{
  # 1. Login Manager
  services.displayManager.ly.enable = true;

  # 2. Audio (PipeWire + WirePlumber)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # 3. Security & Keyring
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # 4. Input
  services.libinput.enable = true;

  # 5. Yazi File Chooser Portal (Single source of truth)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "gtk" ];
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

  # 6. MIME Associations (Zen Browser & Yazi)
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "text/html" = lib.mkForce "zen-beta.desktop";
      "x-scheme-handler/http" = lib.mkForce "zen-beta.desktop";
      "x-scheme-handler/https" = lib.mkForce "zen-beta.desktop";
      "x-scheme-handler/about" = lib.mkForce "zen-beta.desktop";
      "x-scheme-handler/unknown" = lib.mkForce "zen-beta.desktop";
      "inode/directory" = lib.mkForce "yazi.desktop";
    };
  };

  # 7. Dark Mode Force (GTK & Qt)
  environment.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    QT_QPA_PLATFORMTHEME = "gtk3";
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
  };

  # 8. Install Yazi and its .desktop entry into /run/current-system/sw/share/applications
  environment.systemPackages = with pkgs; [
    yazi
    yaziDesktop
  ];
}
