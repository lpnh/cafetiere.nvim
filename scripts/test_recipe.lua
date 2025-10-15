-- Run with: nvim -l scripts/test_recipe.lua

-- Add plugin to path
package.path = package.path .. ";lua/?.lua;lua/?/init.lua"

local recipe = require("cafetiere.recipe")

local errors = {}

-- 1. Check all required keys are present in semantic groups
for _, key in ipairs(recipe.semantic_group_keys) do
	if not recipe.semantic_groups[key] then
		table.insert(errors, string.format("semantic_groups missing required key: `%s`", key))
	end
end

-- 2. Check no extra keys are present in semantic groups
for key, _ in pairs(recipe.semantic_groups) do
	local found = false
	for _, expected_key in ipairs(recipe.semantic_group_keys) do
		if key == expected_key then
			found = true
			break
		end
	end
	if not found then
		table.insert(errors, string.format("semantic_groups has unexpected key: `%s`", key))
	end
end

-- 3. Check for duplicate cterm numbers across semantic groups
local cterm_to_groups = {}
for group_name, cterm_numbers in pairs(recipe.semantic_groups) do
	for _, cterm in ipairs(cterm_numbers) do
		if cterm_to_groups[cterm] then
			table.insert(
				errors,
				string.format("duplicate cterm `%d`: it appears in `%s` and `%s`", cterm, cterm_to_groups[cterm], group_name)
			)
		else
			cterm_to_groups[cterm] = group_name
		end
	end
end

-- 4. Check coverage of all 256 cterm colors (0-255)
local missing_cterms = {}
for i = 0, 255 do
	if not cterm_to_groups[i] then
		table.insert(missing_cterms, i)
	end
end

if #missing_cterms > 0 then
	table.insert(
		errors,
		string.format("%d cterm colors not mapped: { %s }", #missing_cterms, table.concat(missing_cterms, ", "))
	)
end

-- 5. Check theme defaults have all required keys (and no extra keys)
for _, theme_name in ipairs { "dark", "light" } do
	local theme_defaults = recipe[theme_name]
	if not theme_defaults then
		table.insert(errors, string.format("recipe.%s table is missing", theme_name))
	else
		for _, key in ipairs(recipe.semantic_group_keys) do
			if not theme_defaults[key] then
				table.insert(errors, string.format("recipe.%s missing key: `%s`", theme_name, key))
			end
		end

		for key, _ in pairs(theme_defaults) do
			local found = false
			for _, expected_key in ipairs(recipe.semantic_group_keys) do
				if key == expected_key then
					found = true
					break
				end
			end
			if not found then
				table.insert(errors, string.format("recipe.%s has unexpected key: `%s`", theme_name, key))
			end
		end
	end
end

-- Result
if #errors > 0 then
	print("The recipe failed:")
	for _, err in ipairs(errors) do
		print("  " .. err)
	end
	print()
	os.exit(1)
else
	print("The recipe is perfect:")
	print(string.format("  %d semantic groups defined", #recipe.semantic_group_keys))
	print(string.format("  %d cterm colors mapped", 256 - #missing_cterms))
	print()
	os.exit(0)
end
