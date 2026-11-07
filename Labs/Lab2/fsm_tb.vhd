----------------------------------------------------------------
-- File-I/O testbench for the fsm(mealy_2p) odd-parity checker.
-- Reads stimuli + expected results from fsm_test_vectors.txt,
-- applies them synchronously to the DUT, and logs a pass/fail
-- line per vector to fsm_results.txt.
-- Vector format per line: reset x expected_y pause description
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;  -- std_logic / std_logic_vector types
use ieee.numeric_std.all;     -- arithmetic (unused here, kept for consistency)
use std.textio.all;           -- file read/write (text, line, READ/WRITE)
use ieee.std_logic_textio.all; -- adds READ/WRITE overloads for std_logic

ENTITY fsm_tb IS
END ENTITY fsm_tb;

ARCHITECTURE testbench OF fsm_tb IS

  COMPONENT fsm IS
    PORT( clk, reset: IN std_logic;
          x: IN std_logic;
          y: OUT std_logic);
  END COMPONENT fsm;
  
  FOR ALL : fsm USE ENTITY work.fsm(mealy_2p);

  SIGNAL clk_in:   std_logic;
  SIGNAL reset_in: std_logic;
  SIGNAL x_in:     std_logic;
  SIGNAL y_out:    std_logic;

BEGIN

  dut : fsm PORT MAP (
    clk   => clk_in,
    reset => reset_in,
    x     => x_in,
    y     => y_out
  );

  -- Free-running 10 ns clock (100 MHz), 50% duty cycle
  clk_gen : PROCESS
  BEGIN
    clk_in <= '0';
    WAIT FOR 5 ns;
    clk_in <= '1';
    WAIT FOR 5 ns;
  END PROCESS;

  -- Drives stimuli from file and self-checks the DUT output
  pd : PROCESS IS
    FILE vectors_f: text OPEN READ_MODE  IS "fsm_test_vectors.txt";
    FILE results_f: text OPEN WRITE_MODE IS "fsm_results.txt";
    VARIABLE stimuli_l, res_l: line;
    VARIABLE reset_in_f, x_in_f, y_exp_f: std_logic;
    VARIABLE pause: natural;
    VARIABLE message: line;
  BEGIN
    reset_in <= '0'; x_in <= '0'; WAIT FOR 10 ns; -- settle before first vector

    WHILE NOT endfile(vectors_f) LOOP
      READLINE(vectors_f, stimuli_l);
      READ(stimuli_l, reset_in_f); -- col 1: reset value to apply
      READ(stimuli_l, x_in_f);     -- col 2: x value to apply
      READ(stimuli_l, y_exp_f);    -- col 3: expected y after the hold
      READ(stimuli_l, pause);      -- col 4: clock cycles to hold inputs
      message := new string'(stimuli_l.all); -- remainder: description, used on failure

      WAIT UNTIL falling_edge(clk_in); -- change inputs away from the sampling edge
      reset_in <= reset_in_f;
      x_in <= x_in_f;

      -- Hold the inputs for 'pause' rising edges, then sample y_out
      FOR i IN 1 TO pause LOOP
        WAIT UNTIL rising_edge(clk_in);
      END LOOP;

      WRITE(res_l, string'("Time is now "));
      WRITE(res_l, NOW);
      WRITE(res_l, string'(" X = "));
      WRITE(res_l, x_in_f);
      WRITE(res_l, string'(", clk = "));
      WRITE(res_l, clk_in);
      WRITE(res_l, string'(", reset = "));
      WRITE(res_l, reset_in);
      WRITE(res_l, string'(", Expected Y = "));
      WRITE(res_l, y_exp_f);
      WRITE(res_l, string'(", Actual Y = "));
      WRITE(res_l, y_out);

      IF y_exp_f /= y_out THEN
        WRITE(res_l, string'(". Test failed! Error:"));
        WRITE(res_l, message.all); -- echo the vector's description to aid debugging
      ELSE
        WRITE(res_l, string'(". Test passed"));
      END IF;
      WRITELINE(results_f, res_l);
    END LOOP;

    WAIT; -- end of test: suspend forever
  END PROCESS;

END ARCHITECTURE testbench;
