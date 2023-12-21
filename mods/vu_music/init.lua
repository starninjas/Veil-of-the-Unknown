--
-- Music
--

local music_player_timer = 0
local cave_music_player_timer = 0
local min_interval = 360  -- 6 minutes in seconds
local max_interval = 640  -- 11 minutes in seconds

--- Overworld

minetest.register_globalstep(function(dtime)
    music_player_timer = music_player_timer + dtime

    if music_player_timer > max_interval then
        music_player_timer = math.random(-min_interval, 0)
        for _, player in ipairs(minetest.get_connected_players()) do
            local pos = player:get_pos()
            pos.y = pos.y + 1.625
            if pos.y > -30 then
                minetest.sound_play("music", {to_player = player:get_player_name(), gain = 0.15})
            end
        end
    end
end)