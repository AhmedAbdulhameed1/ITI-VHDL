ENTITY integrator IS 
	PORT (d_in: IN real := 0.0;
	      clk, start, stop: IN bit;
	      d_out: OUT real);
END ENTITY integrator;
ARCHITECTURE behav OF integrator IS BEGIN 
	p: process (clk) IS 
		VARIABLE temp real:=0.0;
	BEGIN
		IF clk ='1' AND clk'event THEN 
			IF start = '1' THEN
				temp := 0.0;
			ELSIF stop ='1' THEN
				d_out = temp;
			ELSE 
				temp := temp + d_in;
			END IF;
		END IF;
	END process p;
END ARCHITECTURE behav;
