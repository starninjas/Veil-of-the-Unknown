
--
-- SNOWY PLAINS
--

-- Snow

function vu_base.snow_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "snow_step", gain = 1.0}
	table.dig = table.dig or
			{name = "snow_step", gain = 1.0}
	table.dug = table.dug or
			{name = "snow_step", gain = 1.0}
	table.place = table.place or
			{name = "snow_step", gain = 1.0}
	return table
end

minetest.register_node("vu_base:00o0", {
	description = "snow",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 3},
	sounds = vu_base.snow_sounds(),
	
	on_select = function(itemstack, player)
		minetest.sound_play("snow_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})

-- Ice

function vu_base.ice_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "ice_step", gain = 1.0}
	table.dig = table.dig or
			{name = "ice_step", gain = 1.0}
	table.dug = table.dug or
			{name = "ice_step", gain = 1.0}
	table.place = table.place or
			{name = "ice_step", gain = 1.0}
	return table
end

minetest.register_node("vu_base:0101e", {
	description = "ice",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_pick = 1},
	sounds = vu_base.ice_sounds(),
	
	on_select = function(itemstack, player)
		minetest.sound_play("ice_step", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})
