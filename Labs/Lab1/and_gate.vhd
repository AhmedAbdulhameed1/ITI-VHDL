library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY xor_gate IS 
PORT (
A, B : IN  std_logic;
Y    : OUT std_logic;
);
END ENTITY;
ARCHITECTURE dataflow OF xor_gate Is
--declarations
BEGIN
Y <= A xor B;
END ARCHITECTURE dataflow;
------------------------------
--DFF
------------------------------
ENTITY DFF IS PORT(
D, clk: IN ;
Q : OUT ;
);
END ENTITY;

ARCHITECTURE behav OF DFF IS
--Declarations
BEGIN
PROCESS(clk)
IF clk = '1' THEN Q <= D;
END PROCESS;
END ARCHITECTURE behav;
-----------------------------
--DFF4
-----------------------------
ENTITY DFF4 IS
PORT (
D : IN (3 DOWNTO 0);
clk : IN ;
Q : OUT (3 DOWNTO 0)
);
END ENTITY DFF;
----------------------
ARCHITECTURE struct OF DFF4 IS
--Declarations
COMPONENT DFF IS PORT(
D, clk : IN BIT;
Q : OUT BIT
);
SIGNAL intclk
FOR ALL : DFF USE ENTITY WORK.DFF (behav);
BEGIN
bit 3 : DFF
	PORT MAP (D(3), clk, Q(3));

bit 2 : DFF
	PORT MAP (D(2), clk, Q(2));

bit 1 : DFF
	PORT MAP (D(1), clk, Q(1));

bit 0 : DFF
	PORT MAP (D(0), clk, Q(0));

END ARCHITECTURE struct;
