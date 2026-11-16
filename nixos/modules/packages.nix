{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ── CLI & shell ──────────────────────────────────────────────
    git curl wget unzip zip 7zz
    ripgrep fd fzf bat jq yq-go tree glow
    htop btop duf fastfetch
    starship zoxide tealdeer translate-shell
    tmux
    pciutils usbutils dmidecode lm_sensors nvtop acpi brightnessctl ddcutil iw
    socat inotify-tools psmisc

    # ── Dev ──────────────────────────────────────────────────────
    neovim vim lazygit
    nodejs python3 python3Packages.pip
    go rustc cargo clang gcc gnumake cmake gdb valgrind
    jdk jdk17 jdk21
    typst taplo ruff shfmt cppcheck eslint
    android-tools scrcpy
    luarocks lua5_4

    # ── Media ────────────────────────────────────────────────────
    mpv imv zathura
    obs-studio wf-recorder gpu-screen-recorder
    ffmpeg imagemagick mediainfo ffmpegthumbnailer

    # ── Hyprland / Wayland / Noctalia ────────────────────────────
    hyprpicker hypridle hyprlock hyprpolkitagent
    grim slurp satty swappy
    wl-clipboard cliphist wl-clip-persist
    wlsunset wl-gammarelay-rs
    wayland-utils wev xwayland-satellite
    quickshell matugen  # For Noctalia shell
    playerctl pamixer
    awww
    cava
    kdeconnect

    # ── Browsers / chat / comms ──────────────────────────────────
    firefox zen-browser
    equibop  # <-- Equibop instead of Vesktop
    thunderbird
    bitwarden

    # ── Gaming ───────────────────────────────────────────────────
    steam-run gamescope mangohud vkbasalt
    prismlauncher heroic

    # ── File managers / misc GUI ─────────────────────────────────
    kitty
    thunar
    kdePackages.dolphin
    xdg-utils

    # ── Office / media apps ──────────────────────────────────────
    onlyoffice-desktopeditors
    spotify spicetify-cli
    vscode

    # ── ASUS / hardware ──────────────────────────────────────────
    asusctl supergfxctl
    tlp

    # ── Security / alt ───────────────────────────────────────────
    gnupg
  ];

  programs.adb.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;
}
