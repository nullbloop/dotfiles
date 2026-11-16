{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ── CLI & shell ──────────────────────────────────────────────
    git curl wget unzip zip _7zz
    ripgrep fd fzf bat jq yq-go tree glow
    htop btop duf fastfetch
    starship zoxide tealdeer translate-shell
    tmux
    pciutils usbutils dmidecode lm_sensors nvtopPackages.full acpi brightnessctl ddcutil iw
    socat inotify-tools psmisc

    # ── Dev ──────────────────────────────────────────────────────
    neovim vim lazygit
    nodejs python3 python3Packages.pip
    go rustc cargo clang gcc gnumake cmake gdb valgrind
    jdk jdk17 jdk21
    typst taplo ruff shfmt cppcheck eslint
    android-tools scrcpy
    luarocks lua5_4 lua-language-server
    nixd
    nixfmt-rfc-style
    # ── Media ────────────────────────────────────────────────────
    mpv imv zathura stremio-linux-shell
    obs-studio wf-recorder gpu-screen-recorder
    ffmpeg imagemagick mediainfo ffmpegthumbnailer
	kdePackages.kolourpaint

    # ── Hyprland / Wayland / Noctalia ────────────────────────────
    hyprpicker hypridle hyprlock hyprpolkitagent
    grim slurp satty swappy
    wl-clipboard cliphist wl-clip-persist
    wlsunset wl-gammarelay-rs
    wayland-utils wev xwayland-satellite
    quickshell matugen  wayvnc
    playerctl pamixer
    awww
    cava noctalia 

    # ── Browsers / chat / comms ────────────────────────────────── 
    equibop karere
    thunderbird
    bitwarden-desktop  

    # ── File managers / misc GUI ─────────────────────────────────
    kitty
    xdg-utils

    # ── Office / media apps ──────────────────────────────────────
    onlyoffice-desktopeditors
    spotify spicetify-cli
    vscode

    # ── ASUS / hardware ──────────────────────────────────────────
    asusctl supergfxctl
    tlp pavucontrol blueman
	mission-center qalculate-qt
	gvfs 

    # ── Security / alt ───────────────────────────────────────────
    gnupg

	nwg-look qt6Packages.qt6ct papirus-icon-theme adw-gtk3 easyeffects
  ];

  }
