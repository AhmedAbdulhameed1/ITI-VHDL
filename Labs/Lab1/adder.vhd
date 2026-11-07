library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY adder IS 
PORT(
    A, B, CIN : IN std_logic;
    S, C      : OUT std_logic
);
END ENTITY adder;

-----------------------------------------------------
ARCHITECTURE struct OF adder IS 
-----------------------------------------------------
COMPONENT halfadder IS PORT(
    A, B : IN  std_logic;
    S, C : OUT std_logic
);
END COMPONENT;
FOR ALL : halfadder USE ENTITY WORK.halfadder (struct);
------------------------------------------------------
SIGNAL C0, C1, S0 : std_logic ;
BEGIN
    ha0 : halfadder PORT MAP (A, B, S0, C0);
    ha1 : halfadder PORT MAP (CIN, S0, S, C1);
    C <= C0 or C1;
END ARCHITECTURE struct;