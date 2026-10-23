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

## Highlights & Features

### Niri & Noctalia (Compositor & UI)
- **Modular Configuration:** Niri configs are split into numbered files (e.g., `10-input`, `20-layout`, `70-binds`) for easy navigation.
- **Seamless Integration:** Bound `Super+E` to launch Yazi, and `Super+W` for Zen Browser.
- **Material You Theming:** Noctalia handles the bar, launcher, and lock screen, while Matugen extracts colors from your wallpaper and applies them system-wide.

### Kitty & Fish (Terminal & Shell)
- **Native Drag & Drop:** Kitty supports Yazi's OSC 72 protocol, letting you drag files directly from the terminal to other apps.
- **Yazi Wrapper:** A custom `y` function in Fish automatically changes your terminal's directory to match wherever you navigated inside Yazi when you quit.

### Fastfetch & Misc
- **System Info:** Fastfetch displays a beautiful Material You-colored logo and system specs on terminal startup.
- **XDG Defaults:** Managed `mimeapps.list` to ensure Yazi, Zen, and MPV are the default applications for their respective file types.

---

<details>
<summary><b>Click to view the Neovim Plugin list</b></summary>
<br>

**UI & Aesthetics**
- `catppuccin/nvim`: The main theme (Mocha flavor).
- `HiPhish/rainbow-delimiters.nvim`: Colorizes matching brackets.
- `lukas-reineke/indent-blankline.nvim`: Adds vertical lines for indentation.
- `nvim-treesitter/nvim-treesitter-context`: Pins function/class definitions to the top of the screen when scrolling.
- `MeanderingProgrammer/render-markdown.nvim`: Renders Markdown natively with GitHub-style overlays.
- `iamcco/markdown-preview.nvim`: Opens a live GitHub-style preview in the browser.
- `folke/which-key.nvim`: Pops up a menu showing available keybinds.
- `folke/trouble.nvim`: A beautiful list viewer for diagnostics and LSP references.
- `rachartier/tiny-inline-diagnostic.nvim`: Replaces default LSP errors with modern inline text.

**Navigation & Files**
- `nvim-neo-tree/neo-tree.nvim`: Traditional file explorer sidebar (configured to show hidden files).
- `nvim-telescope/telescope.nvim`: Fuzzy finder for files, buffers, and live grep.
- `mikavilpas/yazi.nvim`: Integrates Yazi as a floating file manager inside Neovim.

**LSP & Autocompletion**
- `williamboman/mason.nvim`: Package manager for LSPs, linters, and formatters.
- `neovim/nvim-lspconfig`: Configures the native Neovim LSP client.
- `hrsh7th/nvim-cmp`: Autocompletion engine.
- `windwp/nvim-autopairs`: Automatically closes brackets and quotes.
- `echasnovski/mini.surround`: Quickly add/change/delete surrounding characters.

**Syntax & Folding**
- `nvim-treesitter/nvim-treesitter`: The core syntax parsing engine.
- `kevinhwang91/nvim-ufo`: Advanced code folding with Treesitter.

**Formatting & Linting**
- `stevearc/conform.nvim`: Runs formatters (Stylua, Black, Prettier, etc.) on save.
- `mfussenegger/nvim-lint`: Runs linters (Ruff, ESLint, Luacheck) in the background.

**Git & Utilities**
- `lewis6991/gitsigns.nvim`: Shows Git diff signs in the gutter and allows hunk staging.
- `mbbill/undotree`: Visualizes the undo history as a tree.
- `folke/todo-comments.nvim`: Highlights keywords like `TODO` and `FIXME`.
- `vyfor/cord.nvim`: Discord Rich Presence.
- `azratul/live-share.nvim`: Real-time collaborative editing.

</details>

<details>
<summary><b>Click to view the detailed Yazi Plugin list</b></summary>
<br>

- `smart-enter`: Opens files or enters directories using the same key (`l`).
- `smart-paste`: Pastes files directly into the hovered directory without entering it.
- `open-with-cmd`: Prompts for a custom command to open the selected file.
- `toggle-pane`: Maximizes, minimizes, or hides the preview pane.
- `git`: Shows Git file statuses in the file list.
- `gvfs`: Mounts USB drives, MTP devices (Android), and network shares.
- `rclone`: Mounts and manages cloud storage (Google Drive, etc.).
- `mediainfo`: Shows detailed metadata and thumbnails for audio and video files in the preview pane.

</details>
