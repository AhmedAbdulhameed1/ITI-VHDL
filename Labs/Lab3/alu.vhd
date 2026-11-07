LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY alu IS 
PORT(
    a, b   : IN unsigned (3 DOWNTO 0);
    opcode : IN std_logic_vector (1 DOWNTO 0);
    en     : IN std_logic;
    y      : OUT unsigned (3 DOWNTO 0)
);
END ENTITY alu;

ARCHITECTURE arch1 OF alu IS 
BEGIN
    P1 : PROCESS(en, opcode, a, b)
    BEGIN
        IF en = '0' THEN
            y <= "0000";
        ELSE
            CASE opcode IS
                WHEN "00" => Y <= a + b;
                WHEN "01" => Y <= a - b;
                WHEN "10" => Y <= a and b;
                WHEN "11" => Y <= a or b;
            END CASE;
        END IF;
    END PROCESS;

END ARCHITECTURE arch1;