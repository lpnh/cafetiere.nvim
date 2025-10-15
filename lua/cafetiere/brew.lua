local recipe = require("cafetiere.recipe")

local M = {}

-- Reverse lookup table for cterm -> semantic group mapping
local cterm_to_semantic_group = {}

for semantic_group, cterm_numbers in pairs(recipe.semantic_groups) do
	for _, n in ipairs(cterm_numbers) do
		cterm_to_semantic_group[n] = semantic_group
	end
end

--- Filter user_opts to only contain valid semantic group keys.
--- Returns a filtered copy with invalid keys removed and warnings issued.
---@param user_opts table User options to filter
---@param theme_name string Name of the theme
---@return table filtered_opts User options with only valid keys
local function filter_user_opts(user_opts, theme_name)
	local filtered = {}
	for user_key, val in pairs(user_opts) do
		local is_valid = false
		for _, valid_key in ipairs(recipe.semantic_group_keys) do
			if user_key == valid_key then
				is_valid = true
				break
			end
		end
		if is_valid then
			filtered[user_key] = val
		else
			vim.notify(string.format("cafetiere.%s: invalid semantic group `%s`", theme_name, user_key), vim.log.levels.WARN)
		end
	end
	return filtered
end

--- Brew theme by mapping semantic groups to palette colors
---@param palette table Catppuccin palette
---@param user_opts table|nil Optional user overrides for semantic groups
---@param theme_name string Name of the theme (for warn messages)
---@param defaults table Default mapping of semantic groups to palette color names
---@return table theme Semantic color mapping
local function brew_theme(palette, user_opts, theme_name, defaults)
	user_opts = user_opts or {}

	-- Filter user options to only valid semantic groups
	local filtered_opts = filter_user_opts(user_opts, theme_name)

	-- Merge with filtered user options
	local mapping = vim.tbl_extend("force", defaults, filtered_opts)

	-- Brew theme by looking up palette colors
	local theme = {}
	for group, palette_key in pairs(mapping) do
		local color = palette[palette_key]
		if not color then
			-- Warn and fall back to default
			vim.notify(
				string.format("cafetiere.%s: invalid palette color `%s`", theme_name, palette_key),
				vim.log.levels.WARN
			)
			color = palette[defaults[group]]
		end
		theme[group] = color
	end

	return theme
end

--- Catppuccin palette colors to semantic groups map for dark theme
---@param palette table Catppuccin palette
---@param user_opts table|nil Optional user_opts semantic groups to palette color names mapping
---@return table theme Semantic color mapping
M.dark = function(palette, user_opts) return brew_theme(palette, user_opts, "dark", recipe.dark) end

--- Catppuccin palette colors to semantic groups map for light theme
---@param palette table Catppuccin palette
---@param user_opts table|nil Optional user_opts semantic groups to palette color names mapping
---@return table theme Semantic color mapping
M.light = function(palette, user_opts) return brew_theme(palette, user_opts, "light", recipe.light) end

--- Find which semantic group a cterm color number belongs to
---@param cterm_color number|string The cterm color number
---@return string|nil group The semantic group name (e.g., "red", "blue", etc.)
M.find_semantic_group = function(cterm_color)
	local num = tonumber(cterm_color)
	return num and cterm_to_semantic_group[num] or nil
end

return M
