-- Store the last played sound index for each player
local last_sound_index = {}
local timer = 0
-- Globalstep function
minetest.register_globalstep(function(dtime)
  timer = timer + dtime
  if timer > 0.5 then
    timer = 0
    -- Get a list of all connected players
    local players = minetest.get_connected_players()

  -- Iterate through each player
      for _, player in ipairs(players) do

        local hp = player:get_hp()

        local hb

        if hp < 3 then
          hb = 4
        elseif hp < 5 then
          hb = 3
        elseif hp < 7 then
          hb = 2
        elseif hp < 9 then
          hb = 1
        end

        local ls = last_sound_index[player]
        -- minetest.chat_send_all(minetest.serialize(ls))
        if ls and ls[2] and hb == ls[2] then return end
        if ls then
          minetest.sound_stop(ls[1])
        end
        if hb then
          local handle = minetest.sound_play("heartbeat"..hb, {
              to_player = player:get_player_name(),
              gain = 1.0, loop = true})
          last_sound_index[player] = {handle, hb}
      end
    end
  end
end)