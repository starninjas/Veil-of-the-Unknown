
--
-- DESERT
--

-- Cactus

function vu_base.log_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "log_dug", gain = 1.0, pitch = 0.8}
	table.dig = table.dig or
			{name = "log_dug", gain = 1.0, pitch = 0.9}
	table.dug = table.dug or
			{name = "cactus_dug", gain = 0.4}
	table.place = table.place or
			{name = "log_dug", gain = 1.0, pitch = 0.9}
	return table
end

minetest.register_node("vu_base:000100", {
	description = "cactus",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 3},
	sounds = vu_base.log_sounds(),
	
	on_select = function(itemstack, player)
		minetest.sound_play("cactus_dug", {gain = 0.8, pitch = 1.5})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})

-- Sand

function vu_base.sand_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "sand_step", gain = 1.0}
	table.dig = table.dig or
			{name = "sand_step", gain = 1.0}
	table.dug = table.dug or
			{name = "gravel_dug", gain = 0.8, pitch = 1.1}
	table.place = table.place or
			{name = "sand_step", gain = 1.0}
	return table
end

minetest.register_node("vu_base:0a01", {
	description = "sand",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 3},
	sounds = vu_base.sand_sounds(),
	
	on_select = function(itemstack, player)
		minetest.sound_play("sand_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})