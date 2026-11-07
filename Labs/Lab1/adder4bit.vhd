library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY adder4bit IS PORT(
    A, B : IN std_logic_vector (3 DOWNTO 0);
    S    : OUT std_logic_vector (3 DOWNTO 0);
    OVR    : OUT std_logic
);
END ENTITY adder4bit;

ARCHITECTURE struct OF adder4bit IS
COMPONENT adder IS PORT(
A, B, CIN : IN std_logic;
S, C      : OUT std_logic 
);
END COMPONENT;
FOR ALL : adder USE ENTITY WORK.adder (struct);
SIGNAL CARRY : std_logic_vector (2 DOWNTO 0);
BEGIN
b0 :  adder PORT MAP (A(0), B(0), '0'       , S(0), CARRY(0));
b1 :  adder PORT MAP (A(1), B(1), CARRY(0)  , S(1), CARRY(1));
b2 :  adder PORT MAP (A(2), B(2), CARRY(1)  , S(2), CARRY(2));
b3 :  adder PORT MAP (A(3), B(3), CARRY(2)  , S(3), CARRY(OVR));

END ARCHITECTURE struct;