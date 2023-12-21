--
-- Misc
--

-- Ash

function vu_base.ash_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "ash_dig", gain = 0.7, pitch = 0.9}
	table.dig = table.dig or
			{name = "ash_dig", gain = 1.0}
	table.dug = table.dug or
			{name = "sand_dig", gain = 1.0, pitch = 0.9}
	table.place = table.place or
			{name = "ash_dig", gain = 1.0, pitch = 0.9}
	return table
end

minetest.register_node("vu_base:001", {
	description = "ashs",
	stack_max = 128,
	tiles = {"blank.png"},
	groups = {by_hand = 2},
	sounds = vu_base.ash_sounds(),	
	
	on_select = function(itemstack, player)
		minetest.sound_play("ash_dig", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
})

--
-- Metal
--

-- Metal

function vu_base.metal_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "metal_dig", gain = 0.9, pitch = 0.9}
	table.dig = table.dig or
			{name = "metal_dig", gain = 1.0}
	table.dug = table.dug or
			{name = "metal_dug", gain = 0.9, pitch = 0.75}
	table.place = table.place or
			{name = "ore_dig", gain = 1.0, pitch = 0.9}
	return table
end

minetest.register_node("vu_base:0010l", {
	description = "metal",
	tiles = {"blank.png"},
	groups = {by_pick = 3},
	sounds = vu_base.metal_sounds(),
	stack_max = 128,
	
	on_select = function(itemstack, player)
		minetest.sound_play("metal_dig", {pitch = 1.3})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pointed_pos = pointed_thing.under
			local pointed_node = minetest.get_node(pointed_pos)

			-- METAL + FIRE = METAL CHIMES
			if itemstack:get_name() == "vu_base:0010l" and pointed_node.name == "fire:basic_flame" then
				minetest.set_node(pointed_pos, { name = "vu_base:0100e0" }) -- chimes
				
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


--- CHIMES

function vu_base.chimes_sounds(table)
	table = table or {}
	table.dig = table.dig or
			{name = "metal_dug", gain = 1.0}
	table.dug = table.dug or
			{name = "chimes_wield", gain = 0.9, pitch = 0.8}
	table.place = table.place or
			{name = "chimes_wield", gain = 1.0}
	return table
end

minetest.register_node("vu_base:0100e0", {
	description = "chimes",
	stack_max = 16,
	tiles = {"blank.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, 0.2500, -0.3125, 0.3125, 0.3750, 0.3125},
			{-0.3125, 0.3750, 0.000, 0.3125, 0.5000, 0.000},
			{-0.2500, -0.8125, -0.2500, -0.1250, 0.1875, -0.1250},
			{-0.2500, -0.7500, -0.1875, -0.1250, 0.2500, -0.1875},
			{-0.1875, -0.5000, 0.1250, -0.06250, 0.1875, 0.2500},
			{-0.1875, -0.4375, 0.1875, -0.06250, 0.2500, 0.1875},
			{0.1250, -0.6250, 0.06250, 0.2500, 0.1875, 0.1875},
			{0.1250, -0.4375, 0.1250, 0.2500, 0.2500, 0.1250},
			{0.000, -0.6875, -0.1875, 0.1250, 0.1875, -0.06250},
			{0.000, -0.3750, -0.1250, 0.1250, 0.2500, -0.1250}
		},
	},
	walkable = true,
	buildable_to = true,
	groups = {by_hand = 2, attached_node = 4},
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.5000, -0.3125, 0.3125, 0.5000, 0.3125},
	},
	
	on_select = function(itemstack, player)
		minetest.sound_play("chimes_wield", {pitch = 1.1})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	sounds = vu_base.chimes_sounds(),
	
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pointed_pos = pointed_thing.under
			local pointed_node = minetest.get_node(pointed_pos)

			-- CHIMES + FIRE = METAL BELL
			if itemstack:get_name() == "vu_base:0100e0" and pointed_node.name == "fire:basic_flame" then
				minetest.set_node(pointed_pos, { name = "bell:bell" }) -- bell
				
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

-- Parameters

local allsounds = {
	["chimes"] = {
		trigger = {"vu_base:0100e0"},
		base_volume = 0.015,
		max_volume = 0.3,
		per_node = 0.001,
	}
}


-- Cache the union of all trigger nodes

local cache_triggers = {}

for sound, def in pairs(allsounds) do
	for _, name in ipairs(def.trigger) do
		table.insert(cache_triggers, name)
	end
end


-- Update sound for player

local function update_sound(player)
	local player_name = player:get_player_name()
	local ppos = player:get_pos()
	ppos = vector.add(ppos, player:get_properties().eye_height)
	local areamin = vector.subtract(ppos, radius)
	local areamax = vector.add(ppos, radius)
	radius = 12

	local pos = minetest.find_nodes_in_area(areamin, areamax, cache_triggers, true)
	if next(pos) == nil then -- If table empty
		return
	end
	for sound, def in pairs(allsounds) do
		-- Find average position
		local posav = {0, 0, 0}
		local count = 0
		for _, name in ipairs(def.trigger) do
			if pos[name] then
				for _, p in ipairs(pos[name]) do
					posav[1] = posav[1] + p.x
					posav[2] = posav[2] + p.y
					posav[3] = posav[3] + p.z
				end
				count = count + #pos[name]
			end
		end

		if count > 0 then
			posav = vector.new(posav[1] / count, posav[2] / count,
				posav[3] / count)

			-- Calculate gain
			local gain = def.base_volume
			if type(def.per_node) == 'table' then
				for name, multiplier in pairs(def.per_node) do
					if pos[name] then
						gain = gain + #pos[name] * multiplier
					end
				end
			else
				gain = gain + count * def.per_node
			end
			gain = math.min(gain, def.max_volume)

			minetest.sound_play(sound, {
				pos = posav,
				to_player = player_name,
				gain = gain,
			}, true)
		end
	end
end


-- Update sound when player joins

minetest.register_on_joinplayer(function(player)
	update_sound(player)
end)


-- Cyclic sound update

local function cyclic_update()
	for _, player in pairs(minetest.get_connected_players()) do
		update_sound(player)
	end
	minetest.after(3.5, cyclic_update)
end

minetest.after(0, cyclic_update)



