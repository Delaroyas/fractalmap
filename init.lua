fractalmap = {}
fractalmap.mod_path = minetest.get_modpath("fractalmap")


--= Load the Sierpinski Carpet fractal mapgen.
dofile(fractalmap.mod_path.."/sierpinski.lua")

--= Load the newton fractal mapgen.
dofile(fractalmap.mod_path.."/newton.lua")

