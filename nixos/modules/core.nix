{
  config,
  pkgs,
  lib,
  ...
}:
let
  zshNoNomatch = lib.hiPrio (
    pkgs.runCommandCC "zsh-no-nomatch" { } ''
      mkdir -p $out/bin
      $CC -O2 -x c - -o $out/bin/zsh << 'EOF'
      #include <unistd.h>
      #include <stdlib.h>

      int main(int argc, char **argv) {
          char **new_argv = malloc(sizeof(char *) * (argc + 3));
          new_argv[0] = "${pkgs.zsh}/bin/zsh";
          int j = 1;
          for (int i = 1; i < argc; i++) {
              if (argv[i][0] != '-' || (argv[i][1] == 'c' && argv[i][2] == '\0')) {
                  new_argv[j++] = "+o";
                  new_argv[j++] = "nomatch";
                  for (; i < argc; i++) new_argv[j++] = argv[i];
                  break;
              }
              new_argv[j++] = argv[i];
          }
          if (j == argc) {
              new_argv[j++] = "+o";
              new_argv[j++] = "nomatch";
          }
          new_argv[j] = NULL;
          execv("${pkgs.zsh}/bin/zsh", new_argv);
          return 1;
      }
      EOF
    ''
  );
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # Locale
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
  services.envfs.enable = true;

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
    initialPassword = "changeme";
  };

  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  # Expose zshNoNomatch in /run/current-system/sw/bin so envfs serves /bin/zsh
  environment.systemPackages = [
    zshNoNomatch
  ];

  # Java library path (outside /bin and /usr/bin FUSE mounts)
  system.activationScripts.fhsCompat = ''
    mkdir -p /usr/share/java
    ln -sfn "/home/npc/projects/src/po-uilib-202609131913/po-uilib.jar" /usr/share/java/po-uilib.jar
  '';

  environment.etc."zsh/zshenv".text = ''
    unsetopt nomatch
  '';

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
    twemoji-color-font
  ];
  fonts.fontconfig.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    JAVA_HOME = "${pkgs.jdk21}";
  };
}
