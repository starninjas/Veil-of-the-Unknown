-- Parameters

local random = math.random

--
-- CAVES
--

--- Cave Ambience (standalone)

minetest.register_globalstep(function(dtime)

	often = 10
	chance = random(170)

	if chance < often then
		for _,player in ipairs(minetest.get_connected_players()) do

		local playerpos = player:get_pos()
		playerpos.y = playerpos.y + 1.625
		if playerpos.y < -15 then

				minetest.sound_play("cave_ambience", {to_player = player:get_player_name(), gain=0.1})
			end	
		end
	end
end)

--
-- SNOW PLAINS
--

ambience.add_set("ice", {

	frequency = 2,

	sounds = {
		{name = "icecrack", length = 5, gain = 0.3},
	},

	nodes = {"vu_base:0101e"},

	sound_check = function(def)

		local c = (def.totals["vu_base:0101e"] or 0)

		if c > 30 then
			return "ice"
		end
	end
})

--- Cold Wind (standalone)

minetest.register_globalstep(function(dtime)

	often = 3
	chance = random(700)
	radius = 7

	if chance < often then
		for _,player in ipairs(minetest.get_connected_players()) do

		local playerpos = player:get_pos()
		playerpos.y = playerpos.y + 1.625

		local c = minetest.find_nodes_in_area(
		{x = playerpos.x - radius, y = playerpos.y - radius, z = playerpos.z - radius},
		{x = playerpos.x + radius, y = playerpos.y + radius, z = playerpos.z + radius}, {"vu_base:0101e", "vu_base:00o0"})

		if playerpos.y > 0 and #c > 5 then

				minetest.sound_play("cold_wind", {to_player = player:get_player_name(), gain=0.4})
			end	
		end
	end
end)


--
-- FOREST
--


--- Crickets (desert, grassland or forest)

ambience.add_set("night", {

	frequency = 900,

	sounds = {
		{name = "crickets", length = 60},
	},

	sound_check = function(def)
		
		local c = minetest.find_nodes_in_area(
		{x = def.pos.x - radius, y = def.pos.y - radius, z = def.pos.z - radius},
		{x =def.pos.x + radius, y = def.pos.y + radius, z = def.pos.z + radius}, {"vu_base:0011e0", "vu_base:0a01", "vu_base:00000"})


		if (def.tod < 0.2 or def.tod > 0.8) and #c > 25 and def.pos.y > -10 then
			return "night"
		end
	end
})

--- Creaking wood (standalone)

minetest.register_globalstep(function(dtime)

	often = 7
	chance = random(35000)
	radius = 7

	if chance < often then
		for _,player in ipairs(minetest.get_connected_players()) do

		local playerpos = player:get_pos()
		local c = minetest.find_nodes_in_area(
		{x = playerpos.x - radius, y = playerpos.y - radius, z = playerpos.z - radius},
		{x = playerpos.x + radius, y = playerpos.y + radius, z = playerpos.z + radius}, {"vu_base:1r00"})

			if #c > 5 then
				minetest.sound_play("creaking_wood1", {to_player = player:get_player_name(), gain=0.2})
			end	
		end
	end
end)

--- Leaves Wind (standalone)

minetest.register_globalstep(function(dtime)

	often = 3
	chance = random(1500)
	radius = 7

	if chance < often then
		for _,player in ipairs(minetest.get_connected_players()) do

		local playerpos = player:get_pos()
		playerpos.y = playerpos.y + 1.625

		local c = minetest.find_nodes_in_area(
		{x = playerpos.x - radius, y = playerpos.y + 3, z = playerpos.z - radius},
		{x = playerpos.x + radius, y = playerpos.y + 32, z = playerpos.z + radius}, {"vu_base:100v00"})

		if playerpos.y > 0 and #c > 5 then

				minetest.sound_play("leaves_wind", {player = player:get_player_name(), gain=0.2})
			end	
		end
	end
end)

--
-- MISC
--

--- Breeze (standalone)

minetest.register_globalstep(function(dtime)

	often = 10
	chance = random(37000)

	if chance < often then
		for _,player in ipairs(minetest.get_connected_players()) do

		local playerpos = player:get_pos()
		playerpos.y = playerpos.y + 1.625

		local tod = minetest.get_timeofday()
		if tod < 0.2 or tod > 0.8 and playerpos.y > 0 then

				minetest.sound_play("breeze", {to_player = player:get_player_name(), gain=0.35})
			end	
		end
	end
end)

--- Rain (standalone)

minetest.register_globalstep(function(dtime)

	often = 10
	radius = 7
	chance = random(10000)

	if chance < often then
		for _,player in ipairs(minetest.get_connected_players()) do

		local playerpos = player:get_pos()
		playerpos.y = playerpos.y + 1.625

		local c = minetest.find_nodes_in_area(
		{x = playerpos.x - radius, y = playerpos.y + radius, z = playerpos.z - radius},
		{x = playerpos.x + radius, y = playerpos.y + radius, z = playerpos.z + radius}, {"vu_base:00000", "vu_base:0011e0"})

		if playerpos.y > 0 and #c > 5 then

				minetest.sound_play("rain", {to_player = player:get_player_name(), gain=0.7})
			end	
		end
	end
end)
