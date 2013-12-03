




local function register_gourd(info) 
	
	local name = info.name
	
	-- done
	minetest.register_craftitem(":gourds:"..name.."_seed", {
		description = name.." Seed",
		inventory_image = "gourds_"..name.."_seed.png",
		on_place = function(itemstack, placer, pointed_thing)
			local above = minetest.env:get_node(pointed_thing.above)
			if above.name == "air" then
				above.name = "gourds:"..name.."_root"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	})
		
	minetest.register_node("gourds:"..name.."_root", {
		paramtype = "light",
		walkable = false,
		drawtype = "plantlike",
		drop = "",
		tiles = {"gourds_"..name.."_root.png"},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
			},
		},
		groups = {snappy=3, flammable=2,plant=1, gourd_root=1, gourd_vines=1 },
		sounds = default.node_sound_leaves_defaults(),

		on_construct = function(pos)
			-- set the initial growth limit
		end,
	})
	
	minetest.register_node("gourds:"..name.."_vines", {
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		drawtype = "nodebox",
		drop = ":gourds:cut_vines 2",
		tiles = {"gourds_"..name.."_vines.png"},
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
		groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1, gourd_vines=1 },
		sounds = default.node_sound_leaves_defaults(),

		on_construct = function(pos)
			-- set the initial growth limit
			-- set meta info on it
		end,
	})
	
	
	minetest.register_node("gourds:"..name.."_vines_flowering", {
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		drawtype = "nodebox",
		drop = ":gourds:cut_vines 2",
		tiles = {"gourds_"..name.."_vines.png"},
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
		groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1, gourd_vines=1 },
		sounds = default.node_sound_leaves_defaults(),

		on_construct = function(pos)
			-- set the initial growth limit
			-- set meta info on it
		end,
	})
	
	
	minetest.register_node("gourds:"..name, {
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		drawtype = "nodebox",
		tiles = {"gourds_"..name..".png"},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.45, -0.5, -0.45, 0.45, 0.35, 0.45}
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.45, -0.5, -0.45, 0.45, 0.35, 0.45}
			},
		},
		groups = {snappy=3, flammable=2, ,plant=1, gourd=1 },
		sounds = default.node_sound_leaves_defaults(),

		on_construct = function(pos)
			-- set the initial growth limit
			-- set meta info on it
		end,
	})
	
	minetest.register_craftitem(":gourds:"..name.."_flesh", {
		description = name.." Flesh",
		inventory_image = "gourds_"..name.."_flesh.png",
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = "gourds:"..name.."_flesh 2",
		recipe = {"gourds:"..name}
	})
	
	
end




