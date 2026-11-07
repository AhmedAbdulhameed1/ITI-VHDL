LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mem IS 
PORT(
    clk, rst, wr_en : IN std_logic;
    data_in      : IN std_logic_vector  (3 DOWNTO 0);
    address      : IN std_logic_vector  (3 DOWNTO 0);
    data_out     : OUT std_logic_vector (3 DOWNTO 0)
);
END ENTITY mem;

ARCHITECTURE ram OF mem IS
TYPE ram_type IS ARRAY (0 TO 15) OF std_logic_vector (3 DOWNTO 0);
SIGNAL ram_signal : ram_type := (OTHERS => (OTHERS => '0')) ;
BEGIN
    data_out <= ram_signal(to_integer(unsigned(address)));
    Pr : PROCESS(clk, rst)
    BEGIN
        IF rst = '0' THEN 
            ram_signal <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
            IF wr_en = '1' THEN
                ram_signal(to_integer(unsigned(address))) <= data_in;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE ram;