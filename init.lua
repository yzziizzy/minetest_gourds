local modpath = minetest.get_modpath("gourds")

gourds = {}

-- dofile(modpath.."/config.lua")
dofile(modpath.."/node_def.lua")
dofile(modpath.."/crafts.lua")
dofile(modpath.."/mapgen.lua")


gourds.register_gourd({
	name = "pumpkin",
	desc = "Pumpkin",
	
	base_speed = 8,
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


minetest.register_craftitem("gourds:pumpkin_slice", {
	description = "Pumpkin Slice",
	inventory_image = "gourds_pumpkin_slice.png",
})
minetest.register_craftitem("gourds:pumpkin_slice_cooked", {
	description = "Roasted Pumpkin",
	inventory_image = "gourds_pumpkin_slice_cooked.png",
	on_use = minetest.item_eat(1)
})

minetest.register_craft({
	type = "shapeless",
	output = "gourds:pumpkin_slice 6",
	recipe = {"gourds:pumpkin_8"},
})
	

minetest.register_craft({
	type = "cooking",
	output = "gourds:pumpkin_slice_cooked",
	recipe = "gourds:pumpkin_slice",
	cooktime = 15
})


gourds.register_gourd({
	name = "watermelon",
	desc = "Watermelon",
	
	base_speed = 7,
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




