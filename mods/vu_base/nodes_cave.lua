
--
-- CAVES
--

-- Stone

function vu_base.stone_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "stone_step", gain = 0.9}
	table.dig = table.dig or
			{name = "stone_dig", gain = 1.0}
	return table
end

minetest.register_node("vu_base:0100e", {
	description = "stone",
	tiles = {"blank.png"},
	groups = {unbreakable = 1},
	sounds = vu_base.stone_sounds(),
	drop = "",
})

--- ORES

-- Ore

function vu_base.ore_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "ore_dig", gain = 0.55, pitch = 0.9}
	table.dig = table.dig or
			{name = "ore_dig", gain = 1.0}
	table.dug = table.dug or
			{name = "pickaxe", gain = 0.9, pitch = 0.9}
	table.place = table.place or
			{name = "pickaxe", gain = 1.0, pitch = 0.8}
	return table
end

minetest.register_node("vu_base:0000", {
	description = "ore",
	tiles = {"blank.png"},
	groups = {by_pick = 3},
	sounds = vu_base.ore_sounds(),
	
	on_select = function(itemstack, player)
		minetest.sound_play("ore_dig", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pointed_pos = pointed_thing.under
			local pointed_node = minetest.get_node(pointed_pos)

			-- ORE + FIRE = METAL
			if itemstack:get_name() == "vu_base:0000" and pointed_node.name == "fire:basic_flame" then
				minetest.set_node(pointed_pos, { name = "vu_base:0010l" }) -- metal
				
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

-- Flint

function vu_base.flint_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "flint_step", gain = 0.5}
	table.dig = table.dig or
			{name = "flint_step", gain = 1.0}
	table.dug = table.dug or
			{name = "stone_step", gain = 1.0, pitch = 1.3}
	table.place = table.place or
			{name = "flint_step", gain = 1.0}
	return table
end

-- "strike_timer" code, based off of MCL2 redstone.

local strike_timer = 0.3

minetest.register_node("vu_base:1l001", {
	description ="flint",
	stack_max = 8,
	tiles = {"blank.png"},
	groups = {by_pick = 2},
	sounds = vu_base.flint_sounds(),
	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "vu_base:pickaxe" then
			minetest.swap_node(pos, {name="vu_base:1l001_lit"})
			local t = minetest.get_node_timer(pos)
			t:start(strike_timer)
		end
	end,
	
		
	on_select = function(itemstack, player)
		minetest.sound_play("flint_step", {pitch = 1.3})
    end,
})

minetest.register_node("vu_base:1l001_lit", {
	description ="flint",
	tiles = {"blank.png"},
	groups = {by_pick = 2, igniter = 1},
	sounds = vu_base.flint_sounds(),
	drop = "vu_base:1l001",

	paramtype = "light",
	light_source = 5,

	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "vu_base:pickaxe" then
			local t = minetest.get_node_timer(pos)
			t:start(strike_timer)
		end
	end,

	-- Turn back to normal node after some time has passed
	on_timer = function(pos, elapsed)
		minetest.swap_node(pos, {name="vu_base:1l001"})
	end,
})