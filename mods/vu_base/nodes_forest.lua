
--
-- FOREST
--

-- Log

function vu_base.log_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "log_step", gain = 1.0}
	table.dig = table.dig or
			{name = "log_dig", gain = 1.0}
	table.dug = table.dug or
			{name = "log_dug", gain = 1.0}
	table.place = table.place or
			{name = "log_dug", gain = 1.0}
	return table
end

minetest.register_node("vu_base:1r00", {
	description = "log",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 4, fuel = 1, kindling = 1, flammable = 1},
	sounds = vu_base.log_sounds(),
		
	on_select = function(itemstack, player)
		minetest.sound_play("log_dig", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})

-- Leaves

function vu_base.leaves_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "leaves_step", gain = 1.0}
	table.dig = table.dig or
			{name = "leaves_step", gain = 1.0}
	table.dug = table.dug or
			{name = "leaves_dug", gain = 1.0}
	table.place = table.place or
			{name = "leaves_dug", gain = 1.0}
	return table
end

minetest.register_node("vu_base:100v00", {
	description = "leaves",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 3, tinder = 1, kindling = 1, flammable = 1},
	sounds = vu_base.leaves_sounds(),
		
	on_select = function(itemstack, player)
		minetest.sound_play("leaves_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})

-- Forest Litter

function vu_base.litter_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "litter_step", gain = 1.0}
	table.dig = table.dig or
			{name = "litter_step", gain = 1.0}
	table.dug = table.dug or
			{name = "litter_step", gain = 1.0}
	table.place = table.place or
			{name = "litter_step", gain = 1.0}
	return table
end

minetest.register_node("vu_base:0011e0", {
	description = "litter",
	tiles = {"blank.png"},
	groups = {by_hand = 3},
	sounds = vu_base.litter_sounds(),
		
	on_select = function(itemstack, player)
		minetest.sound_play("litter_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	drop = "vu_base:00000",
})
