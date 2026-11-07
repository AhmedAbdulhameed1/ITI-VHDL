library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY andgate IS 
PORT(
A, B : IN std_logic;
C : OUT std_logic
);
END ENTITY andgate;

ARCHITECTURE struct OF andgate IS 
BEGIN
C <= A and B;
END ARCHITECTURE struct;
