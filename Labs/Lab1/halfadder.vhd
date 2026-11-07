library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Required for unsigned arithmetic

ENTITY halfadder IS
PORT(
A, B : IN std_logic;
S, C : OUT std_logic
);
END ENTITY halfadder;

ARCHITECTURE struct OF halfadder IS 
    COMPONENT andgate IS PORT (
        A, B : IN std_logic;
        C    : OUT std_logic
        );
    END COMPONENT;
    FOR ALL : andgate USE ENTITY WORK.andgate (struct);
    ------------------------------------------------
    COMPONENT xorgate IS PORT (
        A, B : IN std_logic;
        C    : OUT std_logic
        );
    END COMPONENT;
    FOR ALL : xorgate USE ENTITY WORK.xorgate (struct);

BEGIN
    AND0 : andgate PORT MAP (A, B, C);
    XOR0 : xorgate PORT MAP (A, B, S);
END ARCHITECTURE struct;