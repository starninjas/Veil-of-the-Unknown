
--
-- CHICKEN
--

mobs:register_mob("mobs_animal:chicken", {
	type = "animal",
	passive = true,
	hp_min = 7,
	hp_max = 7,
	armor = 50,
	collisionbox = {-0.4, -0.75, -0.4, 0.4, 0.1, 0.4},
	visual = "sprite",
	textures = {
		{"heart.png"}, -- only memers know
	},
	makes_footstep_sound = true,
	sounds = {
		distance = 20,
		random = "chicken_random",
		damage = "chicken_hurt",
		death = "chicken_death",
	},
	walk_velocity = 1.0,
	run_velocity = 1.5,
	fall_speed = -4,
	fear_height = 5,
	runaway = true,
	jump = true,
	jump_height = 2,
	pushable = true,
	drops = {
		{name = "mobs_animal:meat_raw", chance = 1, min = 1, max = 1},
		--{name = "mobs_animal:feather", chance = 1, min = 0, max = 2}
	},
	view_range = 5,
})


if not mobs.custom_spawn_animal then

	mobs:spawn({
		name = "mobs_animal:chicken",
		nodes = {"vu_base:00000"},
		interval = 60,
		chance = 700,
		day_toggle = true,
		active_object_count = 3
	})
end


mobs:register_egg("mobs_animal:chicken", "chicken", "blank.png")