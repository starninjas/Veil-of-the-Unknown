
-- Recongizing

awards.register_award("d_soil",{
	title = "THE FEEL OF SOIL",
	description = "You learned to recongize the earthy feel of soil.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:00000",
		target = 32,
	}
})

awards.register_award("d_snow",{
	title = "THE FEEL OF SNOW",
	description = "You learned to recongize the cold touch of snow.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:00o0",
		target = 16,
	}
})

awards.register_award("d_sand",{
	title = "THE FEEL OF SAND",
	description = "You learned to recongize the grainy texture of sand.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:0a01",
		target = 16,
	}
})

awards.register_award("d_wood",{
	title = "THE FEEL OF WOOD",
	description = "You learned to recongize the roughness of wood.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:1r00",
		target = 32,
	}
})

awards.register_award("d_cactus",{
	title = "THE FEEL OF CACTUS",
	description = "You learned to feel the sharp spines of a cactus",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:000100",
		target = 16,
	}
})

awards.register_award("d_leaves",{
	title = "THE FEEL OF LEAVES",
	description = "You learned to recongize the familiar crunch of leaves.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:100v00",
		target = 32,
	}
})

-- OTHERS

awards.register_award("smelt",{
	title = "LEARNED TO SMELT",
	description = "You learned to use fire to smelt ore.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:0010l",
		target = 1,
	}
})

awards.register_award("tinker",{
	title = "LEARNED TO TINKER",
	description = "You learned to tinker.",
	icon = "awards_discovery.png",
	secret = true,
	trigger = {
		type = "dig",
		node = "vu_base:0100e0",
		target = 1,
	}
})