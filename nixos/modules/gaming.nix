{ pkgs, ... }:
{
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    vkbasalt
    prismlauncher
    heroic
  ];
}
