


minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.0002,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"grassland", "deciduous_forest", "floatland_grassland"},
	y_min = 4,
	y_max = 31000,
	decoration = "gourds:vine_root",
	param2 = 4,
})






