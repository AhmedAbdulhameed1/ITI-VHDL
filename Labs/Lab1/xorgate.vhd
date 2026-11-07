library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY xorgate IS 
PORT(
A, B : IN std_logic;
C : OUT std_logic
);
END ENTITY xorgate;

ARCHITECTURE struct OF xorgate IS 
BEGIN
C <= A xor B;
END ARCHITECTURE struct;