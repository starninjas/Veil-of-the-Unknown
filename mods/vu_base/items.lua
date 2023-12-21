--
-- GENERAL
--

minetest.register_craftitem("vu_base:stick", {
	description = "stick",
	inventory_image = "heart.png",
	
	on_select = function(itemstack, player)
		minetest.sound_play("sticks_wield")
		minetest.sound_play("select", {pitch = 1.3})
    end
})

--
-- TOOLS
--

-- Pickaxe

minetest.register_tool("vu_base:pickaxe", {
	description = "pickaxe",
	inventory_image = "heart.png", -- if you're looking at this code, you probably know how things work around here now
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			by_pick = {times={[1]=2.0, [2]=2.5, [3]=3.5}, uses=0, maxlevel=1},
			by_hand = {times={[1]=0.4,[2]=0.8,[3]=2.0, [4]=4.0}, uses=0},
		},
		damage_groups = {fleshy=4},
	},
	groups = {pickaxe = 1},
	
	on_select = function(itemstack, player)
		minetest.sound_play("pickaxe", {gain = 0.8})
		minetest.sound_play("select", {pitch = 1.3})
    end,
	
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pointed_pos = pointed_thing.under
			local pointed_node = minetest.get_node(pointed_pos)

			-- PICKAXE striking wood = STICK
			if itemstack:get_name() == "vu_base:pickaxe" and pointed_node.name == "vu_base:1r00" then
				minetest.add_item(pointed_pos, "vu_base:stick")
				minetest.set_node(pointed_pos, { name = "air" }) -- replace w/ air
				
				minetest.sound_play("craft")

			end
		end
	end
})

-- Strong Pickaxe

minetest.register_tool("vu_base:matock", {
	description = "matock",
	inventory_image = "heart.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			by_pick = {times={[1]=1.7, [2]=2.0, [3]=3.0}, uses=10, maxlevel=1},
			by_hand = {times={[1]=0.3,[2]=0.7,[3]=1.7, [4]=3.2}, uses=10},
		},
		damage_groups = {fleshy=4},
	},
	groups = {pickaxe = 1},
	
	on_select = function(itemstack, player)
		minetest.sound_play("pickaxe", {gain = 1.1})
		minetest.sound_play("select", {pitch = 1.3})
    	end
})

-- Register the /pick command
minetest.register_chatcommand("pick", {
    description = "Gives the player a pickaxe",
    privs = {give=true},
    func = function(name, param)
        local player = minetest.get_player_by_name(name)

        if player then
            -- Give the player a pickaxe item
            local itemstack = ItemStack("vu_base:pickaxe")
            local leftover = player:get_inventory():add_item("main", itemstack)

            -- Inform the player if the inventory is full
            if not leftover:is_empty() then
                minetest.chat_send_player(name, "Your inventory is full. Drop something to make room for the pickaxe.")
            else
                minetest.chat_send_player(name, "You received a pickaxe.")
            end
        end
    end,
})