# sillymamaco's Dotfiles

My personal Linux configuration. Built for speed, keyboard-centric workflows, and Material You theming.

## The Stack

- **OS:** Arch Linux
- **Compositor:** [Niri](https://github.com/YaLTeR/niri) (Scrollable-tiling Wayland compositor)
- **Shell/UI:** [Noctalia](https://github.com/noctalia-dev/noctalia)
- **Theming:** [Matugen](https://github.com/InioX/matugen) (Material You color generation)
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Shell:** [Fish](https://fishshell.com/)
- **Editor:** [Neovim](https://neovim.io/)
- **File Manager:** [Yazi](https://github.com/sxyazi/yazi)

## Repository Structure

This repository aggregates all my relevant `.config` files, linking them to their original place in the `~/.config` folder. This makes it so that all editing I ever need to do is in the same place.

```text
~/dotfiles/
├── fastfetch/
├── fish/
├── kitty/
├── matugen/
├── misc/         # Standalone configs (starship.toml, mimeapps.list)
├── niri/
├── noctalia/
├── nvim/
└── yazi/
```

## Installation

### 1. Dependencies

**Neovim:**
Install the required tools using your preferred package manager. On Arch Linux:
```bash
sudo pacman -S ripgrep fd fzf gcc make unzip nodejs npm python
```
*After opening Neovim, run `:Lazy sync` and `:Mason` to install plugins and LSPs.*

**Yazi:**
Install the required preview and integration tools:
```bash
sudo pacman -S ffmpegthumbnailer mediainfo chafa poppler gvfs gvfs-mtp gvfs-gphoto2 rclone
```

### 2. Linking the Dotfiles 
To apply these configurations, you must symlink the folders from this repository into your `~/.config` directory. 

```bash
ln -s ~/dotfiles/<folder-name> ~/.config/<folder-name>
```

## Features

Here is a breakdown of the custom configurations and features included for each package in this repository.

### Niri
- **Modular Configuration:** Split into numbered files (e.g., `10-input`, `20-layout`, `70-binds`) for easy navigation.
- **Seamless Integration:** Bound `Super+E` to launch Yazi inside Kitty, and `Super+W` for Zen Browser.
- **Polkit & Keyring:** Auto-starts GNOME Keyring and Polkit for graphical authentication.

### Noctalia & Matugen (UI & Theming)
- **Material You (Dynamic Theming):** Matugen extracts colors from your current wallpaper and generates matching color schemes for Kitty, GTK, Neovim, and Fastfetch.
- **Quickshell UI:** Noctalia handles the top bar, launcher, notification daemon, and lock screen.

### Kitty (Terminal)
- **Native Drag & Drop:** Supports Yazi's OSC 72 protocol, allowing you to drag files directly from the terminal into Discord or WhatsApp.
- **Scrollback Fix:** Custom `clear` alias ensures the scrollback buffer is completely wiped.

### Fish (Shell)
- **Yazi Wrapper:** Includes a custom `y` function that tracks the directory you navigate to inside Yazi and automatically `cd`s your terminal to that location when you quit.
- **Prompt:** Starship prompt with custom Material You colors.

### Neovim (Editor)
- **File Management:** Deeply integrated with `yazi.nvim` to open floating file managers, and `neo-tree` for a traditional sidebar.
- **LSP & Autocomplete:** Full LSP support via Mason, `nvim-cmp`, and Treesitter.
- **Java Ready:** Includes a custom `<leader>rj` keybind to instantly compile and run the current Java file.
- **Markdown Preview:** Renders Markdown natively in Neovim with GitHub-style overlays, plus a live browser preview via `markdown-preview.nvim` (`<Space>mp`).
- **SSH Safe:** Configured `OSC 52` clipboard support to prevent Neovim from crashing or lagging when yanking text over SSH.
- **UI:** Tiny Inline Diagnostics, Trouble, and Catppuccin Mocha theme.

### Yazi (File Manager)
- **Vim-Style Keybinds:** Mirrors the Neovim workflow (using `<Space>` as the leader key).
- **Cloud & Device Mounting:** Integrated with `rclone` (for cloud drives) and `gvfs` (for mounting USB drives and Android phones).
- **Content Previews:** Uses `mediainfo` and `ffmpegthumbnailer` to show video thumbnails, audio metadata, and code previews instantly.
- **Smart Operations:** `smart-enter` (open file or enter dir with one key) and `smart-paste` (pastes directly into hovered directories).

### Fastfetch & Misc
- **System Info:** Fastfetch displays a beautiful Material You-colored logo and system specs on terminal startup.
- **XDG Defaults:** Managed `mimeapps.list` to ensure Yazi, Zen, and MPV are the default applications for their respective file types.


