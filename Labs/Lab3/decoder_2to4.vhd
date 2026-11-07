LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder_2to4 IS 
PORT (
    a  : IN bit_vector (1 DOWNTO 0);
    en : IN bit;
    y  : OUT bit_vector (3 DOWNTO 0)
);
END ENTITY decoder_2to4;

ARCHITECTURE decoder OF decoder_2to4 IS
BEGIN
    pd: PROCESS(a, en) IS
    BEGIN
        IF en ='0' THEN
            y <= "0000";
        ELSE
            CASE a IS
                WHEN "00" => y <= "0001";
                WHEN "01" => y <= "0010";
                WHEN "10" => y <= "0100";
                WHEN "11" => y <= "1000";
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE decoder;