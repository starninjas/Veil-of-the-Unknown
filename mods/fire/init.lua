-- Global namespace for functions
fire = {}

--
-- Items
--

function fire.fire_sounds(table)
	table = table or {}
	table.dig = table.dig or
			{name = "fire_extinguish_flame", gain = 0.5, pitch = 1.3}
	table.dug = table.dug or
			{name = "fire_extinguish_flame", gain = 0.5}
	return table
end

-- Flame nodes
local fire_node = {
	drawtype = "nodebox",
	tiles = {"blank.png"},
	inventory_image = "blank.png",
	paramtype = "light",
	light_source = 1,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	damage_per_second = 1,
	groups = {igniter = 2, by_hand = 1, fire = 1},
	drop = "",
	on_flood = flood_flame,
	sounds  = fire.fire_sounds()
}

-- Basic flame node
local flame_fire_node = table.copy(fire_node)
flame_fire_node.description = "Fire"
flame_fire_node.groups.not_in_creative_inventory = 1
flame_fire_node.on_timer = function(pos)
	if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	end
	-- Restart timer
	return true
end
flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(30, 80))
end

minetest.register_node("fire:basic_flame", flame_fire_node)

-- Permanent flame node
local permanent_fire_node = table.copy(fire_node)
permanent_fire_node.description = "Permanent Fire"

minetest.register_node("fire:permanent_flame", permanent_fire_node)


--
-- Sound
--
	local handles = {}
	local timer = 0

	-- Parameters
	local radius = 8 -- Flame node search radius around player
	local cycle = 3 -- Cycle time for sound updates

	-- Update sound for player
	function fire.update_player_sound(player)
		local player_name = player:get_player_name()
		-- Search for flame nodes in radius around player
		local ppos = player:get_pos()
		local areamin = vector.subtract(ppos, radius)
		local areamax = vector.add(ppos, radius)
		local fpos, num = minetest.find_nodes_in_area(
			areamin,
			areamax,
			{"fire:basic_flame", "fire:permanent_flame"}
		)
		-- Total number of flames in radius
		local flames = (num["fire:basic_flame"] or 0) +
			(num["fire:permanent_flame"] or 0)
		-- Stop previous sound
		if handles[player_name] then
			minetest.sound_stop(handles[player_name])
			handles[player_name] = nil
		end
		-- If flames
		if flames > 0 then
			-- Find centre of flame positions
			local fposmid = fpos[1]
			-- If more than 1 flame
			if #fpos > 1 then
				local fposmin = areamax
				local fposmax = areamin
				for i = 1, #fpos do
					local fposi = fpos[i]
					if fposi.x > fposmax.x then
						fposmax.x = fposi.x
					end
					if fposi.y > fposmax.y then
						fposmax.y = fposi.y
					end
					if fposi.z > fposmax.z then
						fposmax.z = fposi.z
					end
					if fposi.x < fposmin.x then
						fposmin.x = fposi.x
					end
					if fposi.y < fposmin.y then
						fposmin.y = fposi.y
					end
					if fposi.z < fposmin.z then
						fposmin.z = fposi.z
					end
				end
				fposmid = vector.divide(vector.add(fposmin, fposmax), 2)
			end
			-- Play sound
			local handle = minetest.sound_play("fire_fire", {
				pos = fposmid,
				to_player = player_name,
				gain = math.min(0.06 * (1 + flames * 0.125), 0.18),
				max_hear_distance = 32,
				loop = true -- In case of lag
			})
			-- Store sound handle for this player
			if handle then
				handles[player_name] = handle
			end
		end
	end

	-- Cycle for updating players sounds
	minetest.register_globalstep(function(dtime)
		timer = timer + dtime
		if timer < cycle then
			return
		end

		timer = 0
		local players = minetest.get_connected_players()
		for n = 1, #players do
			fire.update_player_sound(players[n])
		end
	end)

	-- Stop sound and clear handle on player leave
	minetest.register_on_leaveplayer(function(player)
		local player_name = player:get_player_name()
		if handles[player_name] then
			minetest.sound_stop(handles[player_name])
			handles[player_name] = nil
		end
	end)


-- Deprecated function kept temporarily to avoid crashes if mod fire nodes call it
function fire.update_sounds_around() end

--
-- ABMs
--

	-- Ignite neighboring nodes, add basic flames
	minetest.register_abm({
		label = "Ignite flame",
		nodenames = {"group:flammable"},
		neighbors = {"group:igniter"},
		interval = 7,
		chance = 12,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"air"})
			if p then
				minetest.set_node(p, {name = "fire:basic_flame"})
			end
		end
	})

	-- Flint fire creating
	minetest.register_abm({
		label = "Flint ignite flame",
		nodenames = {"group:tinder"},
		neighbors = {"cp_core:flint_lit"},
		interval = 1,
		chance = 1,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"air"})
			if p then
				minetest.set_node(p, {name = "fire:basic_flame"})
			end
		end
	})

-- Remove kindling nodes around basic flame
	minetest.register_abm({
		label = "Remove kindling nodes",
		nodenames = {"fire:basic_flame"},
		neighbors = "group:kindling",
		interval = 7,
		chance = 16,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"group:flammable"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(p)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(p)
			else
				minetest.remove_node(p)
				minetest.check_for_falling(p)
			end
		end
	})

-- Remove fuel nodes around basic flame
	minetest.register_abm({
		label = "Remove fuel nodes",
		nodenames = {"fire:basic_flame"},
		neighbors = "group:fuel",
		interval = 32,
		chance = 16,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"group:flammable"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(p)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(p)
			else
				minetest.set_node(p, {name = "vu_base:001"}) -- replace with ash
				minetest.check_for_falling(p)
			end
		end
	})