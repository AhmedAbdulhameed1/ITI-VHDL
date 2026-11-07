library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY adder4 IS PORT(
    A, B : IN std_logic_vector (3 DOWNTO 0);
    S    : OUT std_logic_vector (3 DOWNTO 0);
    OVR    : OUT std_logic
);
END ENTITY adder4;
-----------------------------------
ARCHITECTURE behav OF adder4 IS
SIGNAL Temp : std_logic_vector (4 DOWNTO 0);
BEGIN
p1 : PROCESS(A, B) IS 
     BEGIN
        Temp <= std_logic_vector( unsigned('0' & A) + unsigned('0' & B) );
        END PROCESS p1;
        OVR <= Temp(4);
        S <= Temp(3 DOWNTO 0);
END ARCHITECTURE behav;
