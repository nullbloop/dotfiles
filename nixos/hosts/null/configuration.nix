{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/packages.nix
    ../../modules/nvidia.nix
    ../../modules/hardware.nix
    ../../modules/desktop.nix
    ../../modules/virtualization.nix
  ];

  networking.hostName = "null";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Modern kernel as requested
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "pcie_aspm=off" ];
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # zram swap for better memory management without disk I/O
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  system.stateVersion = "24.11";
}
