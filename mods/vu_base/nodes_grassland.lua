
--
-- Grassland
--

-- Soil/Turf/Grass

function vu_base.grass_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "grass_step", gain = 0.7, pitch = 0.9}
	table.dig = table.dig or
			{name = "dirt_step", gain = 1.0}
	table.dug = table.dug or
			{name = "grass_step", gain = 1.0, pitch = 0.6}
	table.place = table.place or
			{name = "dirt_step", gain = 1.0}
	return table
end

minetest.register_node("vu_base:00000", {
	description = "grass",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 3},
	sounds = vu_base.grass_sounds(),	
	
	on_select = function(itemstack, player)
		minetest.sound_play("grass_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pointed_pos = pointed_thing.under
			local pointed_node = minetest.get_node(pointed_pos)

			-- DIRT + FIRE = BRICKS
			if itemstack:get_name() == "vu_base:00000" and pointed_node.name == "fire:basic_flame" then
				minetest.set_node(pointed_pos, { name = "vu_base:100010" }) --bricks
				
				minetest.sound_play("craft")
				minetest.sound_play("extinguish", {gain = 0.5}) -- include if fire crafting

				if itemstack:get_count() > 1 then
					itemstack:set_count(itemstack:get_count() - 1)
					return itemstack
				else
					return ItemStack("")
				end
			end
		end

		return itemstack
	end
})

-- Gravel

function vu_base.gravel_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "gravel_step", gain = 0.8}
	table.dig = table.dig or
			{name = "gravel_step", gain = 1.0}
	table.dug = table.dug or
			{name = "gravel_dug", gain = 1.0}
	table.place = table.place or
			{name = "gravel_dug", gain = 1.0, pitch = 0.8}
	return table
end

minetest.register_node("vu_base:000001", {
	description = "gravel",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 4},
	sounds = vu_base.gravel_sounds(),	
	
	on_select = function(itemstack, player)
		minetest.sound_play("gravel_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	drop = {
		max_items = 1,
		items = {
			{items = {"vu_base:1l001"}, rarity = 5},
			{items = {"vu_base:000001"}}
		}
	}
})

--- MAN-MADE

-- Bricks

function vu_base.bricks_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "brick_step", gain = 0.7, pitch = 0.9}
	table.dig = table.dig or
			{name = "brick_step", gain = 1.0}
	table.dug = table.dug or
			{name = "dirt_step", gain = 1.0, pitch = 0.8}
	table.place = table.place or
			{name = "brick_step", gain = 1.0}
	return table
end

minetest.register_node("vu_base:100010", {
	description = "bricks",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_pick = 2},
	sounds = vu_base.bricks_sounds(),	
	
	on_select = function(itemstack, player)
		minetest.sound_play("brick_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})