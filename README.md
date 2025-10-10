# cafetiere.nvim

Brew your favorite icons with your favorite flavor.

`cafetiere` blends the `catppuccin` palette into `nvim-web-devicons` icons so
they always match your colorscheme.

## Screenshots

`nvim-web-devicons` defaults (left) and `catppuccin`'s Mocha and Latte (right)

<details>
  <summary>Dark theme</summary>
    <img width="114" height="961" alt="Image" src="https://github.com/user-attachments/assets/f3c3d8f8-547b-4270-b052-2b17abfd0be6" />
    <img width="114" height="961" alt="Image" src="https://github.com/user-attachments/assets/0f745723-3829-42b0-9609-420b6832c9a8" />
</details>

<details>
  <summary>Light theme</summary>
    <img width="114" height="961" alt="Image" src="https://github.com/user-attachments/assets/d279cefb-e68c-42bf-947c-94eb60890dca" />
    <img width="114" height="961" alt="Image" src="https://github.com/user-attachments/assets/d95f2df4-6ad2-421f-a035-cd22f9c0e267" />
</details>

## Requirements

- [catppuccin/nvim](https://github.com/catppuccin/nvim)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "lpnh/cafetiere.nvim",
  dependencies = {
    "catppuccin/nvim",
    "nvim-web-devicons",
  },
  opts = {},
}
```

## Usage

Call `setup` after your `catppuccin` and `nvim-web-devicons` configuration:

```lua
require("cafetiere").setup()
```

The plugin automatically detects your current flavor and updates the icons
accordingly. Even when you change themes.

### Customization

You can override the default color mapping by assigning Catppuccin colors to
semantic groups.

#### Available Options

**Semantic Groups**: There are 14 color groups you can customize:

- `grey`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`
- `bright_grey`, `bright_red`, `bright_green`, `bright_yellow`, `bright_blue`,
  `bright_magenta`, `bright_cyan`

**Catppuccin Colors**: You can use any color from the [Catppuccin
palette](https://github.com/catppuccin/catppuccin#-palette)

#### Example

```lua
require("cafetiere").setup({
  -- Overrides for dark themes (mocha, frappe, macchiato)
  dark = {
    bright_blue = "sky",     -- Use a brighter blue
    bright_magenta = "pink", -- Use pink instead of mauve
  },
  -- Overrides for light theme (latte)
  light = {
    grey = "overlay2", -- Use a darker grey
    yellow = "peach",  -- Use peach instead of yellow
  },
})
```

#### Default mappings

```lua
dark = {
  grey = "overlay1",
  red = "red",
  green = "green",
  yellow = "peach",
  blue = "blue",
  magenta = "mauve",
  cyan = "teal",
  bright_grey = "text",
  bright_red = "maroon",
  bright_green = "green",
  bright_yellow = "yellow",
  bright_blue = "blue",
  bright_magenta = "mauve",
  bright_cyan = "sapphire",
},

light = {
  grey = "subtext1",
  red = "red",
  green = "green",
  yellow = "yellow",
  blue = "blue",
  magenta = "mauve",
  cyan = "teal",
  bright_grey = "surface0",
  bright_red = "maroon",
  bright_green = "green",
  bright_yellow = "yellow",
  bright_blue = "sky",
  bright_magenta = "pink",
  bright_cyan = "sapphire",
},
```

## How It Works

`cafetiere` maps `nvim-web-devicons`' `cterm_color` numbers to 14 semantic
groups (grey, red, green, yellow, blue, magenta, cyan + bright variants), then
applies your current Catppuccin palette to those groups.

This ensures icons stay visually coherent across all Catppuccin flavors while
preserving their original semantic colors.

## Acknowledgments

- [Catppuccin](https://github.com/catppuccin), for the soothing pastel theme. The
warmest flavors one could ask for.
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), for
providing and maintaining the icons we all rely on.
