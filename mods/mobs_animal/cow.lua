
--
-- COW
--

mobs:register_mob("mobs_animal:cow", {
	type = "animal",
	passive = true,
	hp_min = 15,
	hp_max = 15,
	armor = 50,
	collisionbox = {-0.8, -0.01, -0.8, 0.8, 1.2, 0.8}, -- thick, because they gotaa be hittable
	visual = "sprite",
	textures = {
		{"heart.png"}, -- only memers know
	},
	makes_footstep_sound = true,
	sounds = {
		distance = 20,
		random = "cow_random",
		damage = "cow_hurt",
		death = "cow_death",
	},
	walk_velocity = 0.5, -- slow, so you can get 'em
	run_velocity = 1.0,
	runaway = true,
	jump = true,
	jump_height = 2,
	pushable = true,
	drops = {
		{name = "mobs_animal:meat_raw", chance = 1, min = 1, max = 3},
		--{name = "mobs:leather", chance = 1, min = 0, max = 2}
	},
	view_range = 8,
	fear_height = 2,
})


if not mobs.custom_spawn_animal then

	mobs:spawn({
		name = "mobs_animal:cow",
		nodes = {"vu_base:00000"},
		interval = 60,
		chance = 700,
		day_toggle = true,
		active_object_count = 2
	})
end


mobs:register_egg("mobs_animal:cow", "Cow", "blank.png")