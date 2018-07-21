
local base_speed = 10




for i = 1,7 do
	local n = 0.1 + (.1 * i)
	minetest.register_node("gourds:gourd_"..i, {
		description = "Unripe Gourd",
		paramtype = "light",
		drawtype = "nodebox",
		drop = "",
		tiles = {"gourds_unripe_gourd.png"},
		node_box = {
			type = "fixed",
			fixed = {
				{-n/2, -0.5, -n/2, n/2, -0.5 + n, n/2}
			},
		},
		groups = {choppy=3, growing_gourd = i, gourd = 1, flammable=3, not_in_creative_inventory=1, plant=1 },
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_node("gourds:gourd_8", {
	description = "Ripe Gourd",
	paramtype = "light",
	drawtype = "nodebox",
	drop = "",
	tiles = {"gourds_ripe_gourd.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4, -0.5, -0.4, 0.4, 0.3, 0.4}
		},
	},
	groups = {choppy=3, flammable=3, gourd=2, plant=1 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("gourds:rotting_gourd", {
	description = "Rotting Gourd",
	paramtype = "light",
	drawtype = "nodebox",
	drop = "",
	tiles = {"gourds_rotting_gourd.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
		},
	},
	groups = {choppy=3, flammable=3, plant=1 },
	sounds = default.node_sound_leaves_defaults(),
})







minetest.register_node("gourds:vine_root", {
	description = "Vine Root",
	drawtype = "plantlike",
	--waving = 1,
	stack_max = 20,
	tiles = {"default_acacia_leaves.png"},
	inventory_image = "default_acacia_leaves.png",
	wield_image = "default_acacia_leaves.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-8 / 16, -0.5, -8 / 16, 8 / 16, 4 / 16, 8 / 16},
	},
})



minetest.register_node("gourds:vines", {
	description = "Vines",
	drawtype = "nodebox",
	paramtype = "light",  
	tiles = {"default_aspen_leaves.png"},
	special_tiles = {"default_aspen_leaves_simple.png"},
	leveled = 2,
	drowning = 1,
	walkable = false, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
	climbable = true, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
-- 	pointable = false,
-- 	diggable = false,
	buildable_to = true,
	groups = {snappy = 3, gourd_vine = 1 },
	sounds = default.node_sound_water_defaults(),
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
		}
	}
})

minetest.register_node("gourds:vines_with_flowers", {
	description = "Vines",
	drawtype = "nodebox",
	paramtype = "light",  
	tiles = {"default_aspen_leaves.png^gourds_flowers.png"},
	special_tiles = {"default_aspen_leaves_simple.png^gourds_flowers.png"},
	leveled = 2,
	drowning = 1,
	walkable = false, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
	climbable = true, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
-- 	pointable = false,
-- 	diggable = false,
	buildable_to = true,
	groups = {snappy = 3, gourd_vine = 1 },
	sounds = default.node_sound_water_defaults(),
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
		}
	}
})

minetest.register_node("gourds:dead_vines", {
	description = "Dead Vines",
	drawtype = "nodebox",
	paramtype = "light",  
	tiles = {"default_acacia_leaves.png"},
	special_tiles = {"default_acacia_leaves_simple.png"},
	leveled = 2,
	drowning = 1,
	walkable = false, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
	climbable = true, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
-- 	pointable = false,
-- 	diggable = false,
	buildable_to = true,
	groups = {snappy = 3,  },
	sounds = default.node_sound_water_defaults(),
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
		}
	}
})


local function swap_leveled(pos, name) 
	local lvl = minetest.get_node_level(pos)
	minetest.set_node(pos, {name=name})
	minetest.set_node_level(pos, lvl)
end


-- vines spawn near the root
minetest.register_abm({
	nodenames = {"gourds:vine_root"},
	interval = base_speed * 5,
	chance = base_speed * 4,
	action = function(pos)
		
		local air_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"air"
		)
		
		local off = math.random(1, #air_nodes)
		for i = 1,#air_nodes do
			--local theirlevel = minetest.get_node_level(fp)
			local fp = air_nodes[((i + off) % #air_nodes) + 1]
			local bp = {x=fp.x, y=fp.y - 1, z=fp.z}
			
		
			
			local bn = minetest.get_node(bp)
			
			if minetest.get_item_group(bn.name, "soil") > 0 then
				minetest.set_node(fp, {name = "gourds:vines"})
				minetest.set_node_level(fp, 10)
				
				return
			end
		end
		

	end
})

-- vines near the root will grow
minetest.register_abm({
	nodenames = {"group:gourd_vine"},
	neighbors = {"gourds:vine_root"},
	interval = base_speed * 1,
	chance = base_speed * 2,
	action = function(pos)
		local mylevel = minetest.get_node_level(pos)
		
		if minetest.get_node_light(pos) > 10 then
			
			minetest.set_node_level(pos, math.min(mylevel + 1, 64))
			
		end
	end
})


-- vines near taller vines will grow
minetest.register_abm({
	nodenames = {"group:gourd_vine"},
	neighbors = {"group:gourd_vine"},
	interval = base_speed * 1,
	chance = base_speed * 2,
	action = function(pos)
		local mylevel = minetest.get_node_level(pos)
		
		local vine_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"group:gourd_vine"
		)
		
		local highest_lvl = 0
		for i = 1,#vine_nodes do
		
			local l = minetest.get_node_level(vine_nodes[i])
			
			if l > highest_lvl then
				highest_lvl = l
			end
		end
		
		
		if highest_lvl > mylevel + 5 then
			minetest.set_node_level(pos, math.min(mylevel + 1, 64))
		end
		
	end
})



-- new vines grow near tall vines
minetest.register_abm({
	nodenames = {"group:gourd_vine"},
	neighbors = {"air"},
	interval = base_speed * 1,
	chance = base_speed * 2,
	action = function(pos)
		local mylevel = minetest.get_node_level(pos)
		if mylevel < 16 then
			return
		end
	
		local vine_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 2, y=pos.y - 2, z=pos.z - 2},
			{x=pos.x + 2, y=pos.y + 2, z=pos.z + 2},
			"group:gourd_vine"
		)
		
		local avg = {x=0, y=0, z=0}
		for _,n in ipairs(vine_nodes) do
			avg.x = avg.x + n.x 
			avg.y = avg.y + n.y 
			avg.z = avg.z + n.z 
		end
		avg.x = avg.x / #vine_nodes 
		avg.y = avg.y / #vine_nodes 
		avg.z = avg.z / #vine_nodes 
		
		
		--local dir = vector.subtract(pos, avg)
	
		local air_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"air"
		)		
		
		local potentials = {}
		local off = math.random(1, #air_nodes)
		for i = 1,#air_nodes do
			--local theirlevel = minetest.get_node_level(fp)
			local fp = air_nodes[((i + off) % #air_nodes) + 1]
			local bp = {x=fp.x, y=fp.y - 1, z=fp.z}
			
			--print(minetest.pos_to_string(fp))
			
			local bn = minetest.get_node(bp)
			
			if minetest.get_item_group(bn.name, "soil") > 0 then
				local dd = vector.distance(fp, avg)
				if dd >2 then 
					table.insert(potentials, {d=dd, pos=fp})
				end
			end
		end
		
		--print(dump2(potentials))
		
		if #potentials == 0 then
			return
		end
		
		--table.sort(potentials, function(a,b) return b.d < a.d end)
		
		minetest.set_node(potentials[1].pos, {name = "gourds:vines"})
		minetest.set_node_level(potentials[1].pos, 1)
		
	end
})



-- vines die unless near a taller vine or a root
minetest.register_abm({
	nodenames = {"group:gourd_vine"},
	interval = base_speed * 1,
	chance = base_speed * 2,
	action = function(pos)
		local mylevel = minetest.get_node_level(pos)
		
		local root_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"gourds:vine_root"
		)
		
		if #root_nodes > 0 then
			return
		end
		
		local vine_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"group:gourd_vine"
		)
		
		for i = 1,#vine_nodes do
			local l = minetest.get_node_level(vine_nodes[i])
			
			if l > mylevel then
				return
			end
		end
		

		minetest.set_node(pos, {name = "gourds:dead_vines"})
		minetest.set_node_level(pos, mylevel * .75)
	end
})


-- dead vines shrink
minetest.register_abm({
	nodenames = {"gourds:dead_vines"},
	interval = base_speed * 1,
	chance = base_speed * 2,
	action = function(pos)
		local mylevel = minetest.get_node_level(pos)
		
		mylevel = mylevel - 2
		
		if mylevel <= 0 then
			minetest.set_node(pos, {name="air"})
		else
			minetest.set_node_level(pos, mylevel)
		end
	end
})




-- some vines grow flowers
minetest.register_abm({
	nodenames = {"group:gourd_vine"},
	interval = base_speed * 5,
	chance = base_speed * 5,
	action = function(pos)
		local mylevel = minetest.get_node_level(pos)
		
		if minetest.get_node_light(pos) > 10 and mylevel > 5 then
			swap_leveled(pos, "gourds:vines_with_flowers")
		end
	end
})

-- vines with flowes grow gourds nearby
minetest.register_abm({
	nodenames = {"gourds:vines_with_flowers"},
	interval = base_speed * 5,
	chance = base_speed * 5,
	action = function(pos)
		
		local air_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"air"
		)		
		
		local off = math.random(1, #air_nodes)
		for i = 1,#air_nodes do
			--local theirlevel = minetest.get_node_level(fp)
			local fp = air_nodes[((i + off) % #air_nodes) + 1]
			local bp = {x=fp.x, y=fp.y - 1, z=fp.z}
			local bn = minetest.get_node(bp)
			
			if minetest.get_item_group(bn.name, "soil") > 0 then
				swap_leveled(pos, "gourds:vines")
				minetest.set_node(fp, {name="gourds:gourd_1"})
				return
			end
		end
		
		swap_leveled(pos, "gourds:vines")
	end
})

-- gourds grow
minetest.register_abm({
	nodenames = {"group:growing_gourd"},
	interval = base_speed * 1,
	chance = base_speed * 1,
	action = function(pos)
		local node = minetest.get_node(pos)
		local lvl = minetest.get_item_group(node.name, "growing_gourd")
		
		minetest.set_node(pos, {name="gourds:gourd_"..(lvl+1)})
	end
})


-- isolated gourds rot
minetest.register_abm({
	nodenames = {"group:gourd"},
	interval = base_speed * 5,
	chance = base_speed * 5,
	action = function(pos)
		
		local vine_nodes = minetest.find_nodes_in_area(
			{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
			{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
			"gourds:gourd_vine"
		)
		
		if #vine_nodes > 0 then
			return
		end
		
		minetest.set_node(pos, {name="gourds:rotting_gourd"})
	end
})

-- ripe gourds eventually rot
minetest.register_abm({
	nodenames = {"gourds:gourd_8"},
	interval = base_speed * 10,
	chance = base_speed * 10,
	action = function(pos)
		minetest.set_node(pos, {name="gourds:rotting_gourd"})
	end
})

-- rotten gourds disappear
minetest.register_abm({
	nodenames = {"gourds:rotting_gourd"},
	interval = base_speed * 1,
	chance = base_speed * 1,
	action = function(pos)
		if math.random(50) == 1 then
			minetest.set_node(pos, {name="gourds:vine_root", param2 = 4})
		else
			minetest.set_node(pos, {name="air"})
		end
	end
})


-- vine roots die eventually
minetest.register_abm({
	nodenames = {"gourds:vine_root"},
	interval = base_speed * 15,
	chance = base_speed * 20,
	action = function(pos)
		minetest.set_node(pos, {name="air"})
	end
})
