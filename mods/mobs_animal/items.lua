
--
-- ITEMS
--

minetest.register_craftitem("mobs_animal:meat_raw", {
	description = "raw meat",
	stack_max = 64,
	inventory_image = "heart.png", -- this is getting old
	groups = {edible = 1},
	
	on_place = function(itemstack, user, pointed_thing)
		minetest.sound_play{name = "eat_raw_meat", gain = 1.0}
		local func = minetest.item_eat(1)
		return func(itemstack, user, pointed_thing)
	end,
	
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pointed_pos = pointed_thing.under
			local pointed_node = minetest.get_node(pointed_pos)

			-- RAW + FIRE = MEAT
			if itemstack:get_name() == "mobs_animal:meat_raw" and pointed_node.name == "fire:basic_flame" then
				minetest.set_node(pointed_pos, { name = "mobs_animal:meat" })
				
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
	end,
	
	on_select = function(itemstack, player)
		minetest.sound_play("raw_meat_wield")
		minetest.sound_play("select", {pitch = 1.3})
    end,
})

function vu_base.meat_sounds(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "meat_wield", gain = 0.5, pitch = 0.8}
	table.dig = table.dig or
			{name = "meat_wield", gain = 1.0, pitch = 0.7}
	table.dug = table.dug or
			{name = "dirt_step", gain = 1.0, pitch = 0.8}
	table.place = table.place or
			{name = "meat_wield", gain = 1.0, pitch = 0.7}
	return table
end


minetest.register_node("mobs_animal:meat", {
	description ="meat",
	stack_max = 64,
	tiles = {"blank.png"},
	groups = {by_hand = 1, edbile = 1},
	sounds = vu_base.meat_sounds(),
	
	on_place = function(itemstack, user, pointed_thing)
		minetest.sound_play{name = "eat_meat", gain = 1.0}
		local func = minetest.item_eat(1)
		return func(itemstack, user, pointed_thing)
	end,
		
	on_select = function(itemstack, player)
		minetest.sound_play("meat_wield")
		minetest.sound_play("select", {pitch = 1.3})
    end,
})
