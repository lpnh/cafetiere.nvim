local M = {}

-- Single source of truth: all semantic group keys that must be present
M.semantic_group_keys = {
	"grey",
	"red",
	"green",
	"yellow",
	"blue",
	"magenta",
	"cyan",
	"bright_grey",
	"bright_red",
	"bright_green",
	"bright_yellow",
	"bright_blue",
	"bright_magenta",
	"bright_cyan",
}

-- Semantic color groups to cterm color numbers mapping
-- stylua: ignore start
M.semantic_groups = {
  ["grey"]           = { 0, 8, 16, 59, 66, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243 },
  ["red"]            = { 1, 52, 88, 124, 160, 174, 196, 202, 209, 210, 217, 223, 224 },
  ["green"]          = { 2, 22, 28, 29, 64, 65, 70, 76, 77, 78, 82, 83, 84, 85, 107, 108, 112, 113, 114, 149, 150, 151 },
  ["yellow"]         = { 3, 58, 94, 100, 106, 101, 130, 136, 142, 143, 144, 148, 166, 172, 178, 180, 184, 208, 214, 215, 220, 227, 228 },
  ["blue"]           = { 4, 17, 18, 19, 20, 21, 24, 25, 26, 27, 57, 61, 62, 63, 68, 69, 75, 81, 99, 105, 111, 146, 225 },
  ["magenta"]        = { 5, 53, 54, 55, 56, 60, 89, 90, 91, 92, 93, 97, 98, 104, 125, 126, 127, 128, 129, 135, 139, 147, 161, 162, 163, 164, 169, 175, 176, 182, 197 },
  ["cyan"]           = { 6, 23, 30, 36, 72, 73, 79, 80, 109, 110, 115, 145, 152 },
  ["bright_grey"]    = { 7, 15, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255 },
  ["bright_red"]     = { 9, 95, 131, 132, 137, 138, 167, 168, 173, 181, 203, 204, 216 },
  ["bright_green"]   = { 10, 34, 35, 40, 41, 42, 46, 47, 48, 49, 71, 118, 119, 120, 121, 155, 156, 157, 191, 192 },
  ["bright_yellow"]  = { 11, 154, 179, 185, 186, 187, 190, 194, 221, 222, 226, 229, 230 },
  ["bright_blue"]    = { 12, 31, 32, 33, 39, 74, 117, 153 },
  ["bright_magenta"] = { 13, 96, 102, 103, 133, 134, 140, 141, 165, 170, 171, 177, 183, 198, 199, 200, 201, 205, 206, 207, 211, 212, 213, 218, 219 },
  ["bright_cyan"]    = { 14, 37, 38, 43, 44, 45, 50, 51, 67, 86, 87, 116, 122, 123, 158, 159, 188, 189, 193, 195, 231 },
}
-- stylua: ignore end

-- Default mapping for dark themes (mocha, frappe, macchiato)
M.dark = {
	["grey"] = "overlay1",
	["red"] = "red",
	["green"] = "green",
	["yellow"] = "peach",
	["blue"] = "blue",
	["magenta"] = "mauve",
	["cyan"] = "teal",
	["bright_grey"] = "text",
	["bright_red"] = "maroon",
	["bright_green"] = "green",
	["bright_yellow"] = "yellow",
	["bright_blue"] = "blue",
	["bright_magenta"] = "mauve",
	["bright_cyan"] = "sapphire",
}

-- Default mapping for light theme (latte)
M.light = {
	["grey"] = "subtext1",
	["red"] = "red",
	["green"] = "green",
	["yellow"] = "yellow",
	["blue"] = "blue",
	["magenta"] = "mauve",
	["cyan"] = "teal",
	["bright_grey"] = "surface0",
	["bright_red"] = "maroon",
	["bright_green"] = "green",
	["bright_yellow"] = "yellow",
	["bright_blue"] = "sky",
	["bright_magenta"] = "pink",
	["bright_cyan"] = "sapphire",
}

return M
