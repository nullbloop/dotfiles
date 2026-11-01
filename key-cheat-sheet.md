# Complete Neovim & Yazi Keymap Reference

**Global Leader Key:** `Space`

## Native Vim Commands 
| Press this | Action |
| :--- | :--- |
| `d` | Delete (e.g., `dd` for line, `dw` for word) |
| `x` | Delete single character |
| `p` | Paste |
| `ggVG` | Select entire file |
| `u` | Undo |
| `Ctrl + r` | Redo |
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |

## Neovim Custom 
| Press this | Action |
| :--- | :--- |
| `Alt + j` | Next paragraph |
| `Alt + k` | Previous paragraph |
| `Space` then `m` | Match bracket |
| `Space` then `dn` | Next Diagnostic |
| `Space` then `dp` | Previous Diagnostic |
| `Space` then `y` | Yank to system clipboard |
| `Space` then `Y` | Yank line to system clipboard |

## Tabs
| Press this | Action |
| :--- | :--- |
| `Space` then `tn` | New tab |
| `Space` then `tx` | Close tab |
| `Space` then `to` | Close *other* tabs |
| `gh` | Previous tab |
| `gl` | Next tab |
| `Space` then `tj` | Next tab |
| `Space` then `tk` | Previous tab |
| `Space` then `tl` | Go to last accessed tab |
| `Space` then `t1` – `t9` | Jump to tab 1–9 |
| `Space` then `t0` | Jump to last tab |
| `Space` then `t,` | Move tab left |
| `Space` then `t.` | Move tab right |

## LSP & Code Actions
| Press this | Action |
| :--- | :--- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gr` | Show references |
| `Space` then `rn` | Rename symbol |
| `Space` then `ca` | Code Action |
| `Space` then `cf` | Format buffer |

## Autocomplete (nvim-cmp)
| Press this | Action |
| :--- | :--- |
| `Ctrl + Space` | **Manually trigger autocomplete** |
| `Ctrl + e` | Abort/Cancel autocomplete |
| `Tab` | Select next completion item |
| `Shift + Tab` | Select previous completion item |
| `Enter` | Confirm completion |

## Folds (nvim-ufo)
| Press this | Action |
| :--- | :--- |
| `zR` | Open all folds |
| `zM` | Close all folds |

## Search & File Explorer
| Press this | Action |
| :--- | :--- |
| `Space` then `b` | Telescope: List open buffers |
| `Space` then `f` | Telescope: Find files |
| `Space` then `g` | Telescope: Live grep (search text) |
| `Space` then `e` | Toggle Neo-tree (file explorer) |
| `Space` then `o` | Focus Neo-tree |
| `Space` then `-` | Open Yazi at current file |
| `Space` then `cw` | Open Yazi in working directory |
| `Ctrl + Up Arrow` | Resume/Toggle Yazi (from Neovim) |

## Git (Gitsigns)
| Press this | Action |
| :--- | :--- |
| `Space` then `hj` | Next git hunk |
| `Space` then `hk` | Previous git hunk |
| `Space` then `hs` | Stage hunk |
| `Space` then `hr` | Reset hunk |
| `Space` then `hp` | Preview hunk |

## Diagnostics & Lists (Trouble)
| Press this | Action |
| :--- | :--- |
| `Space` then `xx` | Toggle all Diagnostics (Workspace) |
| `Space` then `xX` | Toggle Buffer Diagnostics |
| `Space` then `cs` | Toggle Symbols |

## Markdown & Typst
| Press this | Action |
| :--- | :--- |
| `Space` then `mr` | Toggle Render Markdown (in-buffer) |
| `Space` then `mp` | Markdown Preview (in browser) |
| `Space` then `tp` | Toggle Typst Preview |
| `Space` then `ts` | Sync Typst Preview cursor |

## Misc
| Press this | Action |
| :--- | :--- |
| `Space` then `tc` | Toggle Treesitter Context |

---

## Yazi (Terminal File Manager)
**Leader Key in Yazi:** `Space`

### Navigation & View
| Press this | Action |
| :--- | :--- |
| `l` | Smart enter (open file / enter dir) |
| `Space` then `e` | Smart enter (open file / enter dir) |
| `Space` then `m` | Maximize/restore preview pane |
| `Ctrl + d` | Scroll preview down |
| `Ctrl + u` | Scroll preview up |
| `Space` then `f` | Fuzzy filter files |

### File Operations
| Press this | Action |
| :--- | :--- |
| `y` or `Space` then `y` | Yank/Copy files |
| `p` or `Space` then `p` | Smart paste (into hovered dir) |
| `d` | Delete file (to trash) |
| `O` | Open with... (prompt for command) |
| `Space` then `a` | Create a new file |
| `Space` then `A` | Create a new directory |

### Mounts, Remotes & Tools
| Press this | Action |
| :--- | :--- |
| `Space` then `g` | Open mount manager |
| `Space` then `r` | Open an Rclone remote (prompts for name) |
| `Space` then `s` | Drag & Drop (`dragon` fallback) |
