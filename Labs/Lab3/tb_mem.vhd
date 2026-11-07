LIBRARY ieee;
USE ieee.std_logic_1164;
USE ieee.numeric_std;

ENTITY tb_mem IS

END ENTITY tb_mem;

ARCHITECTURE testbench OF tb_mem IS
    --/////////////////
    --Component
    COMPONENT mem IS PORT(
                            clk, rst, wr_en : IN std_logic;
                            data_in      : IN std_logic_vector  (3 DOWNTO 0);
                            address      : IN std_logic_vector  (3 DOWNTO 0);
                            data_out     : OUT std_logic_vector (3 DOWNTO 0)
    );
    END COMPONENT;
    SIGNAL clk_tb : std_logic <= '0';
    SIGNAL rst_tb : std_logic <= '1';
    SIGNAL wr_en_tb : std_logic <= '0';
    SIGNAL data_in_tb         : std_logic_vector  (3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL address_tb         : std_logic_vector  (3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL data_out_tb       : std_logic_vector (3 DOWNTO 0) := (OTHERS => '0');
    FOR ALL : mem USE ENTITY WORK.mem(ram); 
BEGIN
    DUT : mem PORT MAP (
                        
    );
    clk_gen : PROCESS
                BEGIN
                    clk_tb <= '1'; WAIT FOR 5 ns;
                    clk_tb <= '0'; WAIT FOR 5 ns;
                END PROCESS;
    test : PROCESS
            BEGIN
                WAIT for 15 ns;
                WAIT UNTIL falling_edge(clk);
                rst_tb <= '0';
                WAIT FOR 15 ns;
                WAIT UNTIL falling_edge(clk);
                wr_en_tb
            END PROCESS;
END ARCHITECTURE testbench;