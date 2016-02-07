
    complex = {}
    
    function complex.new (r, i) return {r=r, i=i} end
    
    -- defines a constant `i'
    complex.i = complex.new(0, 1)
    
    function complex.add (c1, c2)
      return complex.new(c1.r + c2.r, c1.i + c2.i)
    end
    
    function complex.sub (c1, c2)
      return complex.new(c1.r - c2.r, c1.i - c2.i)
    end
    
    function complex.mul (c1, c2)
      return complex.new(c1.r*c2.r - c1.i*c2.i,
                         c1.r*c2.i + c1.i*c2.r)
    end
    
    function complex.inv (c)
      local n = c.r^2 + c.i^2
      return complex.new(c.r/n, -c.i/n)
    end
    
    function complex.abs (c)
      local n2 = c.r^2 + c.i^2
      return math.sqrt(n2)
    end

    return complex



-- http://www.mitchr.me/SS/newton/
local MaxCount = 255
local MultCol  = 15
local Tol      = .0001	
local r1=complex.new(1, 0)
local r2=complex.new(-1/2, sin(2*pi/3))
local r3=complex.new(-1/2, -sin(2*pi/3))

-- ramCanvas4c8b theRamCanvas = ramCanvas4c8b(4096, 4096, -2.0, 2, -2, 2); 
             
for(int y=0;y<theRamCanvas.get_numYpix();y++) { --
	for(int x=0;x<theRamCanvas.get_numXpix();x++) { --
		p = =complex.new(x, z)
			int  count = 0;
			while((count < MaxCount) and (complex.abs(complex.sub(p,r1)) >= Tol) && (complex.abs(complex.sub(p,r2)) >= Tol) and (complex.abs(complex.sub(p,r3)) >= Tol)) do
				if(abs(z) > 0) then
					--z = z-(z*z*z-1.0)/(z*z*3.0);
					p = complex.sub(p,   complex.div( complex.sub(complex.mul(complex.mul (p, p), p),1.0) , complex.mul(3,complex.mul(p, p)) )  )
				end
			count++;
			end
         if(complex.abs(complex.sub(p,r1)) < Tol) then
                count
         elseif(complex.abs(complex.sub(p,r2)) < Tol) then
                count
         elseif(complex.abs(complex.sub(p,r3)) < Tol) then
                count
         end          
	end
end

