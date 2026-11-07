LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;

ENTITY tb IS 

END ENTITY tb;

ARCHITECTURE tb OF tb IS
--Declarations for DUT and signals
COMPONENT fsm IS PORT (
clk, reset, x : IN std_logic;
y : OUT std_logic
);
END COMPONENT;
FOR DUT : fsm USE ENTITY WORK.fsm(mealy_2p);
	SIGNAL clk_in , reset_in, x_in, y_out : std_logic;
BEGIN
	DUT : fsm PORT MAP (
			   clk => clk_in,
			   reset => reset_in,
			   x => x_in,
			   y => y_out);

clk_gen : PROCESS Is
		BEGIN
			clk_in <= '0'; WAIT FOR 5 ns;
			clk_in <= '1'; WAIT FOR 5 ns;
		END PROCESS;
testbench : PROCESS IS
	FILE vectors_f : text OPEN READ_MODE IS "fsm_test_vectors.txt";
	FILE results_f : text OPEN WRITE_MODE IS "fsm_test_results.txt";
	VARIABLE stimuli_l, result_l : line;
	VARIABLE reset_in_f, x_in_f, y_expec_f : std_logic;
	VARIABLE pause : natural;
	VARIABLE msg : line;
		BEGIN
			reset_in <= '0'; x_in <= '0'; WAIT FOR 10 ns;
			WHILE NOT ENDFILE (vectors_f) LOOP
				READLINE(vectors_f, stimuli_l);
				READ(stimuli_l, reset_in_f);
				READ(stimuli_l, x_in_f);
				READ(stimuli_l, y_expec_f);
				READ(stimuli_l, pause);
				msg := new string'(stimuli_l.ALL);
				WAIT UNTIL FALLING_EDGE(clk_in);	
				reset_in <= reset_in_f;
				x_in 	 <= x_in_f;
				FOR i IN 1 TO pause LOOP
			                WAIT UNTIL rising_edge(clk_in);
				END LOOP;	
				WAIT FOR 1 ns;
				WRITE(result_l, string'("x_ in is "));
				WRITE(result_l, x_in_f);
				WRITE(result_l, string'(" and the expected y_out is "));
				WRITE(result_l, y_expec_f);
				WRITE(result_l, string'(", actual y_out is "));
				WRITE(result_l, y_out);
				WRITE(result_l, string'(", clk is = "));
				WRITE(result_l, clk_in);
				WRITE(result_l, string'(", reset is "));
				WRITE(result_l, reset_in_f);
				WRITE(result_l, string'(". This happened at time  "));
				WRITE(result_l, NOW);
      				IF y_expec_f /= y_out THEN
        				WRITE(result_l, string'(". Test failed! Error:"));
        				WRITE(result_l, msg.all); -- echo the vector's description to aid debugging
      				ELSE
        				WRITE(result_l, string'(". Test passed"));
      				END IF;
      				WRITELINE(results_f, result_l);
			END LOOP;
		ASSERT FALSE REPORT "Simulation finished - all vectors applied" SEVERITY FAILURE;
		END PROCESS;

	
END ARCHITECTURE tb;
