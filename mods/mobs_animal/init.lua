local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

-- Translation support
local S = minetest.get_translator("mobs_animal")

-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_animal = true
	input:close()
	input = nil
end


-- helper function
local function ddoo(mob)

	if minetest.settings:get_bool("mobs_animal." .. mob) == false then
		print("[Mobs_Animal] " .. mob .. " disabled!")
		return
	end

	dofile(path .. mob .. ".lua")
end

ddoo("cow")
ddoo("chicken")
ddoo("coyote")
ddoo("items")

-- Load custom spawning
if mobs.custom_spawn_animal then
	dofile(path .. "spawn.lua")
end


-- Lucky Blocks
if minetest.get_modpath("lucky_block") then
	dofile(path .. "lucky_block.lua")
end


print ("[MOD] Mobs Animal loaded")
