{ config, pkgs, ... }:
{
  services.asusd.enable = true;
  services.supergfxd.enable = true;

  services.power-profiles-daemon.enable = true;

  services.upower.enable = true;
  powerManagement.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.fstrim.enable = true;

  services.fwupd.enable = true;
}
