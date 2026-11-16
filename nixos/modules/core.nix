{
  config,
  pkgs,
  lib,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # Locale (en_US with Lisbon time; adjust LC_* if you prefer pt_PT)
  time.timeZone = "Europe/Lisbon";
  services.timesyncd.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
  };
  console.keyMap = "us";

  # System services
  services.dbus.implementation = "broker";
  programs.dconf.enable = true;

  # Network
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-openconnect
    ];
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = false;
      AllowTcpForwarding = true;
      KexAlgorithms = [
        "curve25519-sha256"
        "curve25519-sha256@libssh.org"
        "diffie-hellman-group-exchange-sha256"
      ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    settings.publish = {
      publish-addresses = true;
      disable-publishing = false;
      disable-user-service-publishing = false;
    };
  };

  services.tailscale.enable = true;

  # User
  users.users.npc = {
    isNormalUser = true;
    description = "npc";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "libvirtd"
      "seat"
    ];
    initialPassword = "changeme"; # change with `passwd` after first boot
  };

  programs.fish.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    twemoji-color-font
  ];
  fonts.fontconfig.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
