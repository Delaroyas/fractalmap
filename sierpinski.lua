
minetest.register_on_mapgen_init(function(mgparams)
	if mgparams.mgname ~= "singlenode" then
		print("[fractalmap] Set mapgen to singlenode")
		minetest.set_mapgen_params({mgname="singlenode"})
	end
end)

minetest.register_chatcommand("regenerate", {
	description = "Regenerates <size * 8>^3 nodes around you",
	params = "<size * 8>",
	privs = {server=true},
	func = function(name, param)
		local size = tonumber(param) or 1

		if size > 8 then
			size = 8 -- Limit: 8*8 -> 64
		elseif size < 1 then
			return false, "Nothing to do."
		end

		size = size * 8
		local player = minetest.get_player_by_name(name)
		local pos = vector.floor(vector.divide(player:getpos(), size))
		local minp = vector.multiply(pos, size)
		local maxp = vector.add(minp, size - 1)

		minetest.generate(minp, maxp, math.random(0, 9999), true)
		return true, "Done!"
	end
})

function fractalmap.generate(minp, maxp, seed, regen)
	--only for plane 0
	if (minp.y>0 or maxp.y<-100) then 
		return
	end


--materials={'bakedclay:dark_green','bakedclay:brown','bakedclay:grey','bakedclay:black','bakedclay:white','bakedclay:cyan','bakedclay:orange'}
materials={'default:dirt_with_grass','default:tree','default:stone','default:cactus','default:stone_with_coal','default:stone_with_iron','default:stone_with_gold','default:stone_with_diamond'}
fractalmap.blocks={}
for i,val in pairs(materials) do
	fractalmap.blocks[i-1]=minetest.get_content_id(val)
end

	local vm,emin,emax
	local blocks={}
	if regen then
		vm = minetest.get_voxel_manip()
		emin, emax = vm:read_from_map(minp, maxp)
	else
		vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	end
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	for z = minp.z, maxp.z do
		for x = minp.x, maxp.x do
			h=0;
			N=math.ceil(math.min(math.log(math.abs(z)),math.log(math.abs(x)))/math.log(3));
			for s=0, N do
				scale=3^(s)
				if ( (math.ceil( x/scale )%3)==2 and (math.ceil( z/scale )%3)==2  ) then
					h=s+1
				end
			end
		
		if (x>0 and z >0) then
			start=minp.y
			stop=math.min(h,maxp.y)
		elseif (x<0 and z >0) then
			start=minp.y
			stop=math.min(0,maxp.y)
		else --	(x<0 and z >0) then
			start=minp.y
			stop=math.min(-h,maxp.y)
		end

		
		for y=start, stop do
			local vi = area:index(x, y, z) 
				data[vi] = fractalmap.blocks[h]
			end
		end
		
	end
	
	vm:set_data(data)
	if regen then
		vm:set_param2_data({})
	end
	if not regen then
		vm:set_lighting({day=0, night=0})
	end
	vm:calc_lighting()
	vm:write_to_map(data)
	vm:update_liquids()
	if regen then
		vm:update_map()
	end
	--minetest.log("action", log_message)
end

table.insert(minetest.registered_on_generateds, 1, fractalmap.generate)
