--
-- Aliases for map generators
--

-- All mapgens

minetest.register_alias("mapgen_stone", "vu_base:0100e")
minetest.register_alias("mapgen_water_source", "vu_base:00000")
minetest.register_alias("mapgen_river_water_source", "vu_base:00000")



--
-- Register biomes
--

minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

--- GRASSLAND

	-- Bush
	
	minetest.register_decoration({
		name = "vu_base:bush",
		deco_type = "schematic",
		place_on = {"vu_base:00000"},
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 137,
			octaves = 3,
			persist = 0.7,
		},
		y_max = 31000,
		y_min = 1,
		place_offset_y = 1,
		schematic = minetest.get_modpath("vu_base") .. "/schematics/bush.mts",
		flags = "place_center_x, place_center_z",
	})
	
	-- Gravel
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"vu_base:00000"},
		sidelen = 4,
		noise_params = {
			offset = -1.5,
			scale = -1.5,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 4,
			persist = 1.0
		},
		y_max = 31000,
		y_min = 1,
		decoration = "vu_base:000001",
		place_offset_y = -1,
		flags = "force_placement",
	})

	
--- FOREST

	minetest.register_biome({
		name = "forest",
		node_top = "vu_base:1011e0",
		depth_top = 1,
		node_filler = "vu_base:10r1",
		depth_filler = 3,
		node_riverbed = "vu_base:10r1",
		depth_riverbed = 2,
		node_riverbed = "vu_base:10r1",
		depth_riverbed = 2,
		heat_point = 2,
		humidity_point = 2,
	})
	
	-- Tree
	
	minetest.register_decoration({
		name = "vu_base:tree",
		deco_type = "schematic",
		place_on = {"vu_base:1011e0"},
		sidelen = 16,
		noise_params = {
			offset = 0.024,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
	   },
		biomes = {"forest"},
		schematic = minetest.get_modpath("vu_base") .. "/schematics/tree.mts",
		flags = "place_center_x, place_center_z",
	})

-- SNOWY PLAINS

	minetest.register_biome({
		name = "snowyplains",
		node_dust = "vu_base:00o0",
		node_top = "vu_base:00o0",
		depth_top = 1,
		node_filler = "vu_base:00o0",
		depth_filler = 3,
		node_stone = "vu_base:0101e",
		node_water_top = "vu_base:0101e",
		depth_water_top = 10,
		heat_point = 1,
		humidity_point = 1,
	})
	
-- DESERT

	minetest.register_biome({
		name = "desert",
		node_top = "vu_base:0a01",
		depth_top = 1,
		node_filler = "vu_base:0a01",
		depth_filler = 1,
		heat_point = 4,
		humidity_point = 1,
	})
	
	-- Cactus

	minetest.register_decoration({
		name = "vu_base:cactus",
		deco_type = "schematic",
		place_on = {"vu_base:0a01"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert"},
		y_max = 31000,
		y_min = 4,
		schematic = minetest.get_modpath("vu_base") .. "/schematics/cactus.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
	
--
-- Register Ores
--

	-- Ore

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "vu_base:0000",
		wherein        = "vu_base:0100e",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 10,
		clust_size     = 3,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "vu_base:0000",
		wherein        = "vu_base:0100e",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 30,
		clust_size     = 5,
	})

--[[ Jungle

	minetest.register_biome({
		name = "jungle",
		node_top = "default:dirt_with_rainforest_litter",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 3,
		node_riverbed = "default:sand",
		depth_riverbed = 2,
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 1,
		heat_point = 86,
		humidity_point = 65,
	})

	minetest.register_biome({
		name = "rainforest_under",
		node_cave_liquid = {"default:water_source", "default:lava_source"},
		node_dungeon = "default:cobble",
		node_dungeon_alt = "default:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 86,
		humidity_point = 65,
	})
	--]]

