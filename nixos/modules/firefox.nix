{ pkgs, inputs, ... }:
{
  # Zen Browser (from flake input)
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Firefox Max Privacy
  programs.firefox = {
    enable = true;
    policies = {
      # Strict Tracking Protection
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      # Disable Telemetry & Data Collection
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFormHistory = true;
      # Force HTTPS
      HttpsOnlyMode = "enabled";
      # Sanitize on close
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false; # Keep cookies for logins, but delete cache
        Downloads = true;
        FormData = true;
        History = true;
        Sessions = true;
        SiteSettings = false;
        OfflineApps = true;
      };
    };
  };
}
