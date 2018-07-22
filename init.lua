local modpath = minetest.get_modpath("gourds")

gourds = {}

-- dofile(modpath.."/config.lua")
-- dofile(modpath.."/gourd_gen.lua")
dofile(modpath.."/node_def.lua")
dofile(modpath.."/crafts.lua")
dofile(modpath.."/mapgen.lua")


gourds.register_gourd({
	name = "pumpkin",
	desc = "Pumpkin",
	
	base_speed = 5,
	grows_on = "soil",
	
	textures = {
		unripe_fruit = "gourds_unripe_gourd.png",
		ripe_fruit = "gourds_ripe_gourd.png",
		rotting_fruit = "gourds_rotting_gourd.png",
		vine_root = "default_aspen_leaves.png",
		vine = "default_aspen_leaves.png",
		vine_flowers = "default_aspen_leaves.png^gourds_flowers.png",
		dead_vine = "default_aspen_leaves.png^[colorize:brown:120",
	},
})

gourds.register_gourd({
	name = "watermelon",
	desc = "Watermelon",
	
	base_speed = 5,
	grows_on = "sand",
	
	textures = {
		unripe_fruit = "gourds_unripe_gourd.png",
		ripe_fruit = "gourds_ripe_gourd.png",
		rotting_fruit = "gourds_rotting_gourd.png",
		vine_root = "default_aspen_leaves.png",
		vine = "default_aspen_leaves.png",
		vine_flowers = "default_aspen_leaves.png^gourds_flowers.png",
		dead_vine = "default_aspen_leaves.png^[colorize:brown:120",
	},
})




