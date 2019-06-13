

gourds.register_gourd = function(def)

	
	local base_speed = def.base_speed

	local root_name = "gourds:"..def.name.."_vine_root"
	local vine_name = "gourds:"..def.name.."_vine"
	local dead_vine_name = "gourds:dead_"..def.name.."_vine"
	local vine_name_flowers = "gourds:"..def.name.."_vine_with_flowers"
	local vine_group = "group:"..def.name.."_vine"
	local rotting_fruit_name = "gourds:rotting_"..def.name
	local ripe_fruit_name = "gourds:"..def.name.."_8"
	local growing_fruit_group = "group:growing_"..def.name

	

	for i = 1,7 do
		local n = 0.1 + (.1 * i)
		minetest.register_node("gourds:"..def.name.."_"..i, {
			description = "Unripe "..def.desc,
			paramtype = "light",
			drawtype = "nodebox",
			drop = "",
			tiles = {def.textures.unripe_fruit},
			node_box = {
				type = "fixed",
				fixed = {
					{-n/2, -0.5, -n/2, n/2, -0.5 + n, n/2}
				},
			},
			groups = {choppy=3, ["growing_"..def.name] = i, [def.name.."_gourd"] = 1, flammable=3, not_in_creative_inventory=1, plant=1 },
			sounds = default.node_sound_leaves_defaults(),
		})
		
	end

	minetest.register_node(ripe_fruit_name, {
		description = "Ripe "..def.desc,
		paramtype = "light",
		drawtype = "nodebox",
		tiles = {def.textures.ripe_fruit},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4, -0.5, -0.4, 0.4, 0.3, 0.4}
			},
		},
		groups = {choppy=3, flammable=3, [def.name.."_gourd"]=2, plant=1 },
		sounds = default.node_sound_leaves_defaults(),
	})

	
	minetest.register_node(rotting_fruit_name, {
		description = "Rotting "..def.desc,
		paramtype = "light",
		drawtype = "nodebox",
		drop = "",
		tiles = {def.textures.rotting_fruit},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.25, 0.25, 0.0, 0.25}
			},
		},
		groups = {choppy=3, [def.name.."_gourd"] = 3, flammable=3, plant=1 },
		sounds = default.node_sound_leaves_defaults(),
	})






	minetest.register_node(root_name, {
		description = def.desc.." Vine Root",
		drawtype = "plantlike",
		--waving = 1,
		stack_max = 20,
		tiles = {def.textures.vine_root},
-- 		inventory_image = "default_acacia_leaves.png",
-- 		wield_image = "default_acacia_leaves.png",
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



	minetest.register_node(vine_name, {
		description = def.desc.." Vines",
		drawtype = "nodebox",
		paramtype = "light",  
		tiles = {def.textures.vine},
		leveled = 2,
		walkable = false, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
		climbable = true, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
		buildable_to = true,
		groups = {snappy = 3, [def.name.."_vine"] = 1 },
		sounds = default.node_sound_water_defaults(),
		node_box = {
			type = "leveled",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			}
		}
	})

	minetest.register_node(vine_name_flowers, {
		description = def.desc.." Vines",
		drawtype = "nodebox",
		paramtype = "light",  
		leveled = 2,
		tiles = {def.textures.vine_flowers},
		walkable = false, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
		climbable = true, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
		buildable_to = true,
		groups = {snappy = 3, [def.name.."_vine"] = 1 },
		sounds = default.node_sound_water_defaults(),
		node_box = {
			type = "leveled",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			}
		}
	})

	minetest.register_node(dead_vine_name, {
		description = "Dead "..def.desc.." Vines",
		drawtype = "nodebox",
		paramtype = "light",  
		tiles = {def.textures.dead_vine},
		leveled = 2,
		walkable = false, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
		climbable = true, -- because viscosity doesn't work for regular nodes, and the liquid hack can't be leveled
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
		nodenames = {root_name},
		interval = 5,
		chance = base_speed * 1,
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
					minetest.set_node(fp, {name = vine_name})
					minetest.set_node_level(fp, 10)
					
					return
				end
			end
			

		end
	})

	-- vines near the root will grow
	minetest.register_abm({
		nodenames = {vine_name},
		neighbors = {root_name},
		interval = 5,
		chance = base_speed * 5,
		action = function(pos)
			local mylevel = minetest.get_node_level(pos)
			
			if minetest.get_node_light(pos) > 10 then
				
				minetest.set_node_level(pos, math.min(mylevel + 5, 64))
				
			end
		end
	})


	-- vines near taller vines will grow
	minetest.register_abm({
		nodenames = {vine_group},
		neighbors = {vine_group},
		interval = 5,
		chance = base_speed * 5,
		action = function(pos)
			local mylevel = minetest.get_node_level(pos)
			
			local vine_nodes = minetest.find_nodes_in_area(
				{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
				{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
				vine_group
			)
			
			local highest_lvl = 0
			for i = 1,#vine_nodes do
			
				local l = minetest.get_node_level(vine_nodes[i])
				
				if l > highest_lvl then
					highest_lvl = l
				end
			end
			
			
			if highest_lvl > mylevel + 3 then
				minetest.set_node_level(pos, math.min(highest_lvl - 1, math.min(mylevel + 5, 64)))
			end
			
		end
	})



	-- new vines grow near tall vines
	minetest.register_abm({
		nodenames = {vine_group},
		neighbors = {"air"},
		interval = 2,
		chance = base_speed * 10,
		action = function(pos)
			local mylevel = minetest.get_node_level(pos)
			if mylevel < 16 then
				return
			end
		
			local vine_nodes = minetest.find_nodes_in_area(
				{x=pos.x - 2, y=pos.y - 2, z=pos.z - 2},
				{x=pos.x + 2, y=pos.y + 2, z=pos.z + 2},
				vine_group
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
			
			minetest.set_node(potentials[1].pos, {name = vine_name})
			minetest.set_node_level(potentials[1].pos, 1)
			
		end
	})



	-- vines die unless near a taller vine or a root
	minetest.register_abm({
		nodenames = {vine_group},
		interval = 2,
		chance = base_speed * 20,
		action = function(pos)
			local mylevel = minetest.get_node_level(pos)
			
			local root_nodes = minetest.find_nodes_in_area(
				{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
				{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
				root_name
			)
			
			if #root_nodes > 0 then
				return
			end
			
			local vine_nodes = minetest.find_nodes_in_area(
				{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
				{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
				vine_group
			)
			
			for i = 1,#vine_nodes do
				local l = minetest.get_node_level(vine_nodes[i])
				
				if l > mylevel then
					return
				end
			end
			

			minetest.set_node(pos, {name = dead_vine_name})
			minetest.set_node_level(pos, mylevel * .75)
		end
	})


	-- dead vines shrink
	minetest.register_abm({
		nodenames = {dead_vine_name},
		interval = 5,
		chance = base_speed * 1,
		action = function(pos)
			local mylevel = minetest.get_node_level(pos)
			
			mylevel = mylevel - 7
			
			if mylevel <= 0 then
				minetest.set_node(pos, {name="air"})
			else
				minetest.set_node_level(pos, mylevel)
			end
		end
	})




	-- some vines grow flowers
	minetest.register_abm({
		nodenames = {vine_group},
		interval = 8,
		chance = base_speed * 30,
		action = function(pos)
			local mylevel = minetest.get_node_level(pos)
			
			if minetest.get_node_light(pos) > 10 and mylevel > 5 then
				swap_leveled(pos, vine_name_flowers)
			end
		end
	})

	-- vines with flowers grow gourds nearby
	minetest.register_abm({
		nodenames = {vine_name_flowers},
		interval = 5,
		chance = base_speed * 20,
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
				
				if minetest.get_item_group(bn.name, def.grows_on) > 0 then
					swap_leveled(pos, vine_name)
					minetest.set_node(fp, {name="gourds:"..def.name.."_1"})
					return
				end
			end
			
			swap_leveled(pos, vine_name)
		end
	})

	-- gourds grow
	minetest.register_abm({
		nodenames = {"group:growing_"..def.name},
		interval = base_speed * 10,
		chance = 2,
		action = function(pos)
			local node = minetest.get_node(pos)
			local lvl = minetest.get_item_group(node.name, "growing_"..def.name)
			
			minetest.set_node(pos, {name="gourds:"..def.name.."_"..(lvl+1)})
		end
	})


	-- isolated gourds rot
	minetest.register_abm({
		nodenames = {"group:"..def.name.."_gourd"},
		interval = 10,
		chance = base_speed * 30,
		action = function(pos)
			
			local vine_nodes = minetest.find_nodes_in_area(
				{x=pos.x - 1, y=pos.y - 1, z=pos.z - 1},
				{x=pos.x + 1, y=pos.y + 1, z=pos.z + 1},
				vine_name
			)
			
			if #vine_nodes > 0 then
				return
			end
			
			minetest.set_node(pos, {name=rotting_fruit_name})
		end
	})

	-- ripe gourds eventually rot
	minetest.register_abm({
		nodenames = {"gourds:"..def.name.."_8"},
		interval = 5,
		chance = base_speed * 20,
		action = function(pos)
			minetest.set_node(pos, {name=rotting_fruit_name})
		end
	})

	-- rotten gourds disappear
	minetest.register_abm({
		nodenames = {rotting_fruit_name},
		interval = 5,
		chance = base_speed * 20,
		action = function(pos)
			if math.random(50) == 1 then
				minetest.set_node(pos, {name=root_name, param2 = 4})
			else
				minetest.set_node(pos, {name="air"})
			end
		end
	})


	-- vine roots die eventually
	minetest.register_abm({
		nodenames = {root_name},
		interval = 120,
		chance = base_speed * 70,
		action = function(pos)
			minetest.set_node(pos, {name="air"})
		end
	})

	
		
	if minetest.global_exists("seasons") then
		
		-- vines die off completely in the winter 
		
-- 		seasons.reg_custom("spring", vine_name, vine_name)
-- 		seasons.reg_custom("summer", vine_name, vine_name)
		seasons.reg_custom("fall", vine_name, dead_vine_name)
		seasons.reg_custom("winter", vine_name, "air")
		
-- 		seasons.reg_custom("spring", vine_name_flowers, vine_name_flowers)
-- 		seasons.reg_custom("summer", vine_name_flowers, vine_name_flowers)
		seasons.reg_custom("fall", vine_name_flowers, dead_vine_name)
		seasons.reg_custom("winter", vine_name_flowers, "air")
		
		seasons.reg_custom("winter", dead_vine_name, "air")
		
		seasons.reg_custom("winter", ripe_fruit_name, rotting_fruit_name)
		for i = 1,7 do
			seasons.reg_custom("winter", "gourds:"..def.name.."_"..i, "air")
		end
		
		
	end
	
	
	
end
	
