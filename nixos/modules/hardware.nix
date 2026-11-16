{ config, pkgs, ... }:
{
  services.asusd.enable = true;
  services.supergfxd.enable = true;

  services.power-profiles-daemon.enable = true;

  services.upower.enable = true;
  powerManagement.enable = true;

  #
  services.fstrim.enable = true;

  services.fwupd.enable = true;
}
