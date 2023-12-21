
vu_base = {}

--- HAND
minetest.override_item("", {
	tool_capabilities = {
		reach = 5, -- help you guys out some
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			by_hand = {times={[1]=0.5,[2]=1.0,[3]=2.5, [4]=4.5}, uses=0},
			unbreakable = {times={[1]=300}, uses=0},
			--by_hand = {times={[1]=0.1,[2]=0.1,[3]=0.1, [4]=0.1}, uses=0}, -- for creative
		},
		damage_groups = {fleshy=2},
	},
	
	on_select = function(itemstack, player)
		minetest.sound_play("select", {pitch = 0.9})
    end,
})

--- PARTICLES

-- Function to get a color based on the world seed
local function get_world_color()
    local seed = tonumber(minetest.get_mapgen_setting("seed")) % 100000000
    math.randomseed(seed)

    local vibrant_colors = {
        "#f7840a:140", -- Orange
        "#F0F:140", -- Pink
		"#00c3ff:140", -- Cyan
        "#8F8:140"  -- Lime Green
    }
	
    return vibrant_colors[math.random(1, #vibrant_colors)]
end

-- Function to spawn particles around a player
local function spawn_particles_around_player(player)
    local player_pos = player:get_pos()
    local world_color = get_world_color()

    minetest.add_particlespawner({
        amount = 5,
        time = 1,
        minpos = {x = player_pos.x - 22, y = player_pos.y + 0.5, z = player_pos.z - 22},
        maxpos = {x = player_pos.x + 22, y = player_pos.y + 3, z = player_pos.z + 22},
        minvel = {x = -0.1, y = 0.1, z = -0.1},
        maxvel = {x = 0.3, y = 0.5, z = 0.3},
        minacc = {x = 0, y = -0.0, z = 0},
        maxacc = {x = 0, y = -0.1, z = 0},
        minexptime = 3,
        maxexptime = 5,
        minsize = 1,
        maxsize = 1,
        collisiondetection = true,
        collision_removal = true,
        vertical = false,
        texpool = {
            {
                name = "particle.png^[multiply:"..world_color,
                alpha_tween = {1, 0},
                blend = "screen",
            },
        },
        glow = 12,
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1.5
        },
    })
end

-- Globalstep registration
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        spawn_particles_around_player(player)
    end
end)

--- SET PLAYER

--[ Set the black sky. Allows very low visibility. That way players don't get discouraged so fast.

minetest.register_on_joinplayer(function(player)
	
	
   	player:hud_add({
		hud_elem_type = "image",
		position = {x = 0.5, y = 0.5},
		scale = {x = -101, y = -101},
		text = "overlay.png",
		z_index = -1,
   	})	
	 
	player:set_properties({
		hp_max = 10
	})
	
	player:set_physics_override ({
		speed = 1.2,
		jump = 1.1,
		sneak_glitch = true
	})
	
	player:set_sky({
        type = "regular",
        sky_color = {
            day_sky         = {r = 5,   g = 5,  b = 5},
            day_horizon     = {r = 5,   g = 5,  b = 5},
            dawn_sky        = {r = 5,   g = 5,  b = 5},
            dawn_horizon    = {r = 5,   g = 5,  b = 5},
            night_sky       = {r = 5,   g = 5,  b = 5},
            night_horizon   = {r = 5,   g = 5,  b = 5},
            indoors         = {r = 5,   g = 5,  b = 5},
            fog_sun_tint    = {r = 5,   g = 5,  b = 5},
            fog_moon_tint   = {r = 5,   g = 5,  b = 5},
            fog_tint_type = "custom"
        }
    })
	
	player:set_sun({visible = false, sunrise_visible = false, texture = "heart.png"}) -- heart.png is blank, so we're gonna use it.
	player:set_moon({visible = false, texture = "heart.png"})
	player:set_stars({visible = false})
	player:set_clouds({density = 0})
	
	player:hud_set_hotbar_image("heart.png") -- same thing here. we cannot sacrfice creating a tiny blank image called "blank2.png". Save resources, use heart.png
	player:hud_set_hotbar_selected_image("heart.png")
	player:hud_set_hotbar_itemcount(24) -- this is the only inventory you get.
	
end)

--]]


--- LOAD FILES

local default_path = minetest.get_modpath("vu_base")

dofile(default_path.."/items.lua")
dofile(default_path.."/mapgen.lua")

-- nodes

dofile(default_path.."/nodes_artificial.lua")
dofile(default_path.."/nodes_cave.lua")
dofile(default_path.."/nodes_desert.lua")
dofile(default_path.."/nodes_forest.lua")
dofile(default_path.."/nodes_grassland.lua")
dofile(default_path.."/nodes_snowyplains.lua")


-- Function to clear player inventory
local function clear_inventory(player)
    local player_inv = player:get_inventory()
	
    player_inv:set_list("main", {})
    player_inv:set_list("craft", {})
    player_inv:set_stack("main", player:get_wield_index(), ItemStack(nil))
end

-- Register an on_death callback
minetest.register_on_dieplayer(function(player)
    clear_inventory(player)
end)

minetest.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()
	minetest.sound_play("breath")
end)