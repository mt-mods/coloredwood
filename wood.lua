-- Woods portion of Colored Wood mod by Vanessa Ezekowitz  ~~  2012-07-17
-- based on my unified dyes modding template.
--
-- License: WTFPL

local colored_block_modname = "coloredwood"
local colored_block_description = "Wood Planks"
local neutral_block = "default:wood"
local colored_block_sunlight = "false"
local colored_block_walkable = "true"
local colored_block_groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2, not_in_creative_inventory=1}
local colored_block_sound = "default.node_sound_wood_defaults()"

-- ------------------------------------------------------------------
-- Generate all of the base color node definitions and all variations
-- except for the greyscale stuff.

-- Hues are on a 30 degree spacing starting at red = 0 degrees.
-- "s50" in a file/item name means "saturation: 50%".
-- Texture brightness levels for the colors are 100%, 66% ("medium"),
-- and 33% ("dark").

local shades = {
	"dark_",
	"medium_",
	""		-- represents "no special shade name", e.g. bright.
}

local shades2 = {
	"Dark ",
	"Medium ",
	""		-- represents "no special shade name", e.g. bright.
}

local hues = {
	"red",
	"orange",
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet"
}

local hues2 = {
	"Red ",
	"Orange ",
	"Yellow ",
	"Lime ",
	"Green ",
	"Aqua ",
	"Cyan ",
	"Sky Blue ",
	"Blue ",
	"Violet ",
	"Magenta ",
	"Red-violet "
}

local greys = {
	"black",
	"darkgrey",
	"grey",
	"lightgrey",
	"white"
}

local greys2 = {
	"Black ",
	"Dark Grey ",
	"Medium Grey ",
	"Light Grey ",
	"White "
}

local greys3 = {
	"black",
	"darkgrey_paint",
	"mediumgrey_paint",
	"lightgrey_paint",
	"white_paint"
}

for shade = 1, 3 do

	local shadename = shades[shade]
	local shadename2 = shades2[shade]

	for hue = 1, 12 do

		local huename = hues[hue]
		local huename2 = hues2[hue]

		local colorname    = colored_block_modname..":wood_"..shadename..huename
		local pngname      = colored_block_modname.."_wood_"..shadename..huename..".png"
		local nodedesc     = shadename2..huename2..colored_block_description
		local s50colorname = colored_block_modname..":wood_"..shadename..huename.."_s50"
		local s50pngname   = colored_block_modname.."_wood_"..shadename..huename.."_s50.png"
		local s50nodedesc  = shadename2..huename2..colored_block_description.." (50% Saturation)"

		minetest.register_node(colorname, {
			description = nodedesc,
			tiles = { pngname },
--			inventory_image = pngname, 
--			wield_image = pngname,
			sunlight_propagates = colored_block_sunlight,
			paramtype = "light",
			walkable = colored_block_walkable,
			groups = colored_block_groups,
			sounds = colored_block_sound
		})

		minetest.register_node(s50colorname, {
			description = s50nodedesc,
			tiles = { s50pngname },
--			inventory_image = s50pngname, 
--			wield_image = s50pngname,
			sunlight_propagates = colored_block_sunlight,
			paramtype = "light",
			walkable = colored_block_walkable,
			groups = colored_block_groups,
			sounds = colored_block_sound
		})

		minetest.register_craft({
		        type = "fuel",
		        recipe = colorname,
		        burntime = 7,
		})

		minetest.register_craft({
		        type = "fuel",
		        recipe = s50colorname,
		        burntime = 7,
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 2",
			recipe = {
				neutral_block,
				neutral_block,
				"unifieddyes:"..shadename..huename
			},
			replacements = { { "unifieddyes:"..shadename..huename, "vessels:glass_bottle"} }
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 2",
			recipe = {
				neutral_block,
				neutral_block,
				"unifieddyes:"..shadename..huename.."_s50"
			},
			replacements = { { "unifieddyes:"..shadename..huename.."_s50", "vessels:glass_bottle"} }
		})

	end
end

-- Generate the "light" shades separately, since they don"t have a low-sat version.

for hue = 1, 12 do

	local huename = hues[hue]
	local huename2 = hues2[hue]
	local colorname    = colored_block_modname..":wood_light_"..huename
	local pngname      = colored_block_modname.."_wood_light_"..huename..".png"
	local nodedesc     = "Light "..huename2..colored_block_description

	minetest.register_node(colorname, {
		description = nodedesc,
		tiles = { pngname },
--		inventory_image = pngname, 
--		wield_image = pngname,
		sunlight_propagates = colored_block_sunlight,
		paramtype = "light",
		walkable = colored_block_walkable,
		groups = colored_block_groups,
		sounds = colored_block_sound
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = colorname,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = colorname.." 2",
		recipe = {
			neutral_block,
			neutral_block,
			"unifieddyes:light_"..huename
		},
		replacements = { { "unifieddyes:light_"..huename, "vessels:glass_bottle"} }
	})
end
	

-- ============================================================
-- The 5 levels of greyscale.
--
-- Oficially these are 0, 25, 50, 75, and 100% relative to white,
-- but in practice, they"re actually 7.5%, 25%, 50%, 75%, and 95%.
-- (otherwise black and white would wash out).

for grey = 1,5 do

	local greyname = greys[grey]
	local greyname2 = greys2[grey]
	local greyname3 = greys3[grey]

	local greyshadename = colored_block_modname..":wood_"..greyname
	local pngname = colored_block_modname.."_wood_"..greyname..".png"
	local nodedesc = greyname2..colored_block_description

	minetest.register_node(greyshadename, {
		description = nodedesc,
		tiles = { pngname },
--		inventory_image = pngname, 
--		wield_image = pngname,
		sunlight_propagates = colored_block_sunlight,
		paramtype = "light",
		walkable = colored_block_walkable,
		groups = colored_block_groups,
		sounds = colored_block_sound
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = greyshadename,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = greyshadename.." 2",
		recipe = {
			neutral_block,
			neutral_block,
			"unifieddyes:"..greyname3
		},
		replacements = { { "unifieddyes:"..greyname, "vessels:glass_bottle"} }
	})

end
