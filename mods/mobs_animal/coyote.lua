
--
-- COW
--

mobs:register_mob("mobs_animal:coyote", {
	type = "monster",
	
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 1,
	group_attack = true,
	
	hp_min = 10,
	hp_max = 10,
	armor = 50,
	collisionbox = {-0.6, -0.01, -0.6, 0.6, 1.2, 0.6},
	visual = "sprite",
	textures = {
		{"heart.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		distance = 32,
		random = "coyote_random",
		warcry = "coyote_hurt",
		damage = "coyote_hurt",
		death = "coyote_death",
	},
	walk_velocity = 0.7,
	run_velocity = 1.1,
	jump = true,
	jump_height = 2,
	pushable = true,
	drops = {
		--{name = "mobs_animal:meat_raw", chance = 1, min = 1, max = 3},
	},
	view_range = 7,
	fear_height = 2,
	
	runaway_from = {"fire:basic_flame"}
})


if not mobs.custom_spawn_animal then

	mobs:spawn({
		name = "mobs_animal:coyote",
		nodes = {"vu_base:00000"},
		interval = 60,
		chance = 700,
		day_toggle = false,
		active_object_count = 2,
		
		min_light = 0,
		max_light = 7,
	})
end


mobs:register_egg("mobs_animal:coyote", "Coyote", "blank.png")