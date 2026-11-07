LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_bit.ALL;
USE WORK.pack_a.ALL;

ENTITY alu_tb IS
END ENTITY alu_tb;

ARCHITECTURE testbench OF alu_tb IS

    COMPONENT alu IS
        PORT (
            op   : IN  op_type;
            a, b : IN  signed(3 DOWNTO 0);
            c    : OUT signed(3 DOWNTO 0)
        );
    END COMPONENT alu;
    FOR ALL : alu USE ENTITY WORK.alu (alu);

    SIGNAL op    : op_type;
    SIGNAL a, b, c : signed(3 DOWNTO 0);

BEGIN

    DUT : alu PORT MAP (op, a, b, c);

    p1 : PROCESS IS
    BEGIN
        ------------------------------------------------------------------
        -- ADD
        ------------------------------------------------------------------
        op <= add; a <= "0100"; b <= "0010"; WAIT FOR 10 ns;
        ASSERT c = "0110" REPORT "ADD TC1 (normal add) failed" SEVERITY ERROR;

        op <= add; a <= "0100"; b <= "1110"; WAIT FOR 10 ns;
        ASSERT c = "0010" REPORT "ADD TC2 ((+ve)+(-ve), never overflows) failed" SEVERITY ERROR;

        op <= add; a <= "0100"; b <= "0100"; WAIT FOR 10 ns;
        ASSERT c = "1000" REPORT "ADD TC3 ((+ve)+(+ve) overflow, true=+8, wraps to -8) failed" SEVERITY ERROR;

        op <= add; a <= "1001"; b <= "1010"; WAIT FOR 10 ns;
        ASSERT c = "0011" REPORT "ADD TC4 ((-ve)+(-ve) overflow, true=-13, wraps to +3) failed" SEVERITY ERROR;

        op <= add; a <= "0100"; b <= "0011"; WAIT FOR 10 ns;
        ASSERT c = "0111" REPORT "ADD TC5 (max positive threshold +7) failed" SEVERITY ERROR;

        op <= add; a <= "1010"; b <= "1110"; WAIT FOR 10 ns;
        ASSERT c = "1000" REPORT "ADD TC6 (max negative threshold -8, exact fit) failed" SEVERITY ERROR;

        ------------------------------------------------------------------
        -- SUB
        ------------------------------------------------------------------
        op <= sub; a <= "0110"; b <= "0100"; WAIT FOR 10 ns;
        ASSERT c = "0010" REPORT "SUB TC1 (normal (+ve)-(+ve), never overflows) failed" SEVERITY ERROR;

        op <= sub; a <= "0110"; b <= "1110"; WAIT FOR 10 ns;
        ASSERT c = "1000" REPORT "SUB TC2 ((+ve)-(-ve) overflow, true=+8, wraps to -8) failed" SEVERITY ERROR;

        op <= sub; a <= "1010"; b <= "0011"; WAIT FOR 10 ns;
        ASSERT c = "0111" REPORT "SUB TC3 ((-ve)-(+ve) overflow, true=-9, wraps to +7) failed" SEVERITY ERROR;

        ------------------------------------------------------------------
        -- MUL
        ------------------------------------------------------------------
        op <= mul; a <= "0010"; b <= "0011"; WAIT FOR 10 ns;
        ASSERT c = "0110" REPORT "MUL TC1 (normal multiply, 2*3, fits exactly) failed" SEVERITY ERROR;

        op <= mul; a <= "1010"; b <= "0011"; WAIT FOR 10 ns;
        ASSERT c = "1110" REPORT "MUL TC2 ((-ve)*(+ve), -6*3=-18, truncates to -2) failed" SEVERITY ERROR;

        op <= mul; a <= "1100"; b <= "1100"; WAIT FOR 10 ns;
        ASSERT c = "0000" REPORT "MUL TC3 (truncation overflow, -4*-4=16, aliases to 0) failed" SEVERITY ERROR;

        op <= mul; a <= "0011"; b <= "0000"; WAIT FOR 10 ns;
        ASSERT c = "0000" REPORT "MUL TC4 (multiply by zero) failed" SEVERITY ERROR;

        ------------------------------------------------------------------
        -- DIV
        ------------------------------------------------------------------
        op <= div; a <= "0110"; b <= "0010"; WAIT FOR 10 ns;
        ASSERT c = "0011" REPORT "DIV TC1 (normal division, 6/2=3) failed" SEVERITY ERROR;

        op <= div; a <= "0110"; b <= "0000"; WAIT FOR 10 ns;

        REPORT "ALU testbench completed";
        WAIT;
    END PROCESS p1;

END ARCHITECTURE testbench;
