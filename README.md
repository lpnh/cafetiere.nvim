# cafetiere.nvim

a smol Neovim plugin that brews soothing warm icons, with your favorite
color flavors.

cafetiere blends the `catppuccin` palette into `nvim-web-devicons`, ensuring
they always match your colorscheme.

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

### Setup

Just call `setup` and the plugin will automatically detect your current
Catppuccin flavor and apply the palette accordingly. It also handles
colorscheme changes, so your icons stay in sync when you switch flavors.

```lua
require("cafetiere").setup()
```

Note: make sure this happens after your `catppuccin` and `nvim-web-devicons` configuration.

### Configuration

To modify the default color mapping, you just need to apply the desired
Catppuccin color to one or more semantic color group you'd like to change.

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

#### Default values

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

cafetiere acts as a bridge between
[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) and
[catppuccin.nvim](https://github.com/catppuccin/nvim):

- Reading the Catppuccin palette for the current flavor
- Reading all the nvim-web-devicons icons and their `cterm_color` values
- Mapping semantic groups to Catppuccin colors and `cterm_color` numbers to
  semantic groups
- Overriding each icon color with the corresponding Catppuccin color

## Rationale

The plugin uses 14 semantic color groups based on the standard 16 terminal
colors (red, green, yellow, blue, magenta, cyan, and their bright variations),
with grey replacing black and white. Some of the reasons behind this choice:
the familiar color categories, enough color distinction between different icon
types, and consistent icon appearance across all Catppuccin flavors.

Long story short, the `cterm_color` numbers to semantic groups mapping
abstraction has two purposes:

- Provide some ergonomics and flexibility to the customization
- Achieve visual coherence without losing the original semantic color for each icon

## Acknowledgments

- [Catppuccin](https://github.com/catppuccin), for the soothing pastel theme. The
warmest flavors one could ask for.
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), for
providing and maintaining the icons we all rely on.
