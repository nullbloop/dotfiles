# Complete Neovim & Yazi Keymap Reference cause I'm super forgetfull

**Global Leader Key:** `<Space>` (Mapped to `<leader>`)

## Neovim (Global & Navigation)
| Key | Action |
| :--- | :--- |
| `H` / `L` | Top / Bottom of screen |
| `<A-j>` | Next paragraph `}` |
| `<A-k>` | Previous paragraph `{` |
| `<leader>m` | Match bracket `%` |
| `<leader>dn` | Next Diagnostic |
| `<leader>dp` | Previous Diagnostic |
| `<leader>y` | Yank to system clipboard |
| `<leader>Y` | Yank line to system clipboard |

## Tabs
| Key | Action |
| :--- | :--- |
| `<leader>tn` | New tab |
| `<leader>tx` | Close tab |
| `<leader>to` | Close *other* tabs |
| `gh` | Previous tab |
| `gl` | Next tab |
| `<leader>tj` | Next tab |
| `<leader>tk` | Previous tab |
| `<leader>tl` | Go to last accessed tab |
| `<leader>t1` – `<leader>t9` | Jump to tab 1–9 |
| `<leader>t0` | Jump to last tab |
| `<leader>t,` | Move tab left |
| `<leader>t.` | Move tab right |

## LSP & Code Actions
*Note: These only apply when a language server is attached to the buffer.*
| Key | Action |
| :--- | :--- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gr` | Show references |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code Action |
| `<leader>fm` | Format buffer (Conform) |

## Autocomplete (nvim-cmp)
| Key | Action |
| :--- | :--- |
| `<Tab>` | Select next completion item |
| `<S-Tab>` | Select previous completion item |
| `<CR>` (Enter) | Confirm completion |

## Text Editing (mini.surround)
| Key | Action |
| :--- | :--- |
| `sa` | Add surrounding (e.g., `sa"` to wrap in quotes) |
| `sd` | Delete surrounding |
| `sr` | Replace surrounding |
| `sf` / `sF` | Find surrounding (right / left) |
| `sh` | Highlight surrounding |
| `sn` | Update `n` lines in surrounding |

## Folds (nvim-ufo)
| Key | Action |
| :--- | :--- |
| `zR` | Open all folds |
| `zM` | Close all folds |

## Plugin Shortcuts

### Search & File Explorer
| Key | Action |
| :--- | :--- |
| `<leader>b` | Telescope: List open buffers |
| `<leader>f` | Telescope: Find files |
| `<leader>g` | Telescope: Live grep (search text) |
| `<leader>e` | Toggle Neo-tree (file explorer) |
| `<leader>o` | Focus Neo-tree |
| `<leader>-` | Open Yazi at current file |
| `<leader>cw` | Open Yazi in working directory |
| `<c-up>` | Resume/Toggle Yazi (from Neovim) |

### Git (Gitsigns)
| Key | Action |
| :--- | :--- |
| `<leader>hj` | Next git hunk |
| `<leader>hk` | Previous git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |

### Diagnostics & Lists (Trouble)
| Key | Action |
| :--- | :--- |
| `<leader>xx` | Toggle all Diagnostics |
| `<leader>xb` | Toggle Buffer Diagnostics |
| `<leader>xs` | Toggle Symbols |
| `<leader>xl` | Toggle LSP References |
| `<leader>xq` | Toggle Quickfix List |

### Markdown & Typst
| Key | Action |
| :--- | :--- |
| `<leader>mr` | Toggle Render Markdown (in-buffer) |
| `<leader>mp` | Markdown Preview (in browser) |
| `<leader>tp` | Toggle Typst Preview |
| `<leader>ts` | Sync Typst Preview cursor |

### Misc
| Key | Action |
| :--- | :--- |
| `<leader>tc` | Toggle Treesitter Context |
| `<leader>u` | Toggle Undotree |

---

## Yazi (Terminal File Manager)
**Leader Key in Yazi:** `<Space>` (Mirrors Neovim)

### Navigation & View
| Key | Action |
| :--- | :--- |
| `l` | Smart enter (open file / enter dir) |
| `<Space>e` | Smart enter (open file / enter dir) |
| `<Space>m` | Maximize/restore preview pane |
| `<C-d>` | Scroll preview down |
| `<C-u>` | Scroll preview up |
| `<Space>f` | Fuzzy filter files |

### File Operations
| Key | Action |
| :--- | :--- |
| `y` / `<Space>y` | Yank/Copy files |
| `p` / `<Space>p` | Smart paste (into hovered dir) |
| `d` | Delete file (to trash) |
| `O` | Open with... (prompt for command) |
| `<Space>a` | Create a new file |
| `<Space>A` | Create a new directory |

### Mounts, Remotes & Tools
| Key | Action |
| :--- | :--- |
| `<Space>g` | Open mount manager |
| `<Space>r` | Open an Rclone remote (prompts for name) |
| `<Space>s` | Drag & Drop (`dragon` fallback) |
