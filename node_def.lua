


minetest.register_craftitem(":gourds:cut_vines", {
	description = "Cut Vines",
	inventory_image = "gourds_cut_vines.png",
})


minetest.register_node("gourds:whithered_vines", {
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = ":gourds:cut_vines 1",
	tiles = {"gourds_whithered_vines.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
		},
	},
	groups = {snappy=3, flammable=3, not_in_creative_inventory=1,plant=1, gourd_vines=1 },
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		-- set the initial growth limit
		-- set meta info on it
	end,
})


