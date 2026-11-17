{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/packages.nix
    ../../modules/hardware.nix
    ../../modules/nvidia.nix
    ../../modules/desktop.nix
    ../../modules/hyprland.nix
    ../../modules/firefox.nix
    ../../modules/gaming.nix
    ../../modules/virtualization.nix
    ../../modules/spicetify.nix
  ];

  networking.hostName = "null";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Modern kernel as requested
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "pcie_aspm=off"
  ];
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  # zram swap for better memory management without disk I/O
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Deduplicates identical files in the Nix store to save massive amounts of space
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "24.11";
}
