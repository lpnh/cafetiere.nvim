local brew = require("cafetiere.brew")

local M = {}

--- Apply Catppuccin color palette to all nvim-web-devicons icons
---@param opts table|nil Options
local function apply_colors(opts)
	opts = opts or {}

	-- Check if required plugins are available
	local has_catppuccin, catppuccin = pcall(require, "catppuccin.palettes")
	if not has_catppuccin then
		vim.notify("cafetiere: `catppuccin.palettes` not found", vim.log.levels.WARN)
		return
	end

	local has_devicons, devicons = pcall(require, "nvim-web-devicons")
	if not has_devicons then
		vim.notify("cafetiere: `nvim-web-devicons` not found", vim.log.levels.WARN)
		return
	end

	-- Set theme from user's colorscheme flavor
	local current_colorscheme = vim.g.colors_name
	local flavor = current_colorscheme:match("^catppuccin%-(.*)")
	local palette = {}
	local theme = {}
	if flavor ~= nil then
		palette = catppuccin.get_palette(flavor)
		if flavor == "latte" then
			theme = brew.light(palette, opts.light)
		else
			theme = brew.dark(palette, opts.dark)
		end
	else
		vim.notify("cafetiere: colorscheme not found", vim.log.levels.WARN)
		return
	end

	-- Get all icons from nvim-web-devicons
	local all_icons = devicons.get_icons()
	if not all_icons then
		vim.notify("cafetiere: Failed to get icons from `nvim-web-devicons`", vim.log.levels.WARN)
		return
	end

	-- Override each icon with Catppuccin colors
	local overrides = {}
	for icon_name, icon_data in pairs(all_icons) do
		if icon_data.cterm_color then
			local group = brew.find_semantic_group(icon_data.cterm_color)
			if group and theme[group] then
				overrides[icon_name] = {
					icon = icon_data.icon,
					color = theme[group],
					cterm_color = icon_data.cterm_color,
					name = icon_data.name,
				}
			end
		end
	end

	-- Apply all user_opts at once
	devicons.set_icon(overrides)
end

--- Setup cafetiere.nvim
---@param opts table|nil Configuration options
---   - dark (table|nil): user color map for dark themes (mocha, frappe, macchiato)
---   - light (table|nil): user color map for light theme (latte)
M.setup = function(opts)
	opts = vim.tbl_deep_extend("force", {}, opts or {})

	-- Store options for later use
	M._opts = opts

	-- Apply colors on setup
	apply_colors(opts)

	-- Auto-refresh when colorscheme changes
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("cafetiere", { clear = true }),
		callback = function()
			-- Only re-apply if Catppuccin is the active colorscheme
			if vim.g.colors_name and vim.g.colors_name:match("^catppuccin") then
				apply_colors(M._opts)
			end
		end,
	})
end

return M
