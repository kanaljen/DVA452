
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.all;

----------------------------------------------
-------- Testbench for multiplier.vhd --------
----------------------------------------------

ENTITY multiplier_tb IS
END multiplier_tb;

ARCHITECTURE arithmictest OF multiplier_tb IS

    component multiplier is 
        PORT( a ,b: in  STD_LOGIC_VECTOR  (3  DOWNTO  0);       
              p : out  STD_LOGIC_VECTOR  (7  DOWNTO  0)); 
    END component; 

    -- intermediate signal declaration
    signal a ,b : STD_LOGIC_VECTOR  (3  DOWNTO  0);
    signal p : STD_LOGIC_VECTOR  (7  DOWNTO  0);

BEGIN
    
    -- instantiation of component
    multi: multiplier port map (a => a,
                                b => b, 
                                p => p);


    PROCESS

        BEGIN

        -- Testcase 1, all zero
        a <= "0000";
        b <= "0000";
        WAIT for 10 ns;

        -- Testcase 2: b is zero
        for I in 0 to 3 loop
            a(I) <= '1';
            WAIT for 10 ns;
        end loop;
        a <= "0000";

        -- Zero Divider
        a <= "0000";
        b <= "0000";
        WAIT for 10 ns;

        -- Testcase 2: a is zero
        for J in 0 to 3 loop
            b(J) <= '1';
            WAIT for 10 ns;
        end loop;
        b <= "0000";

        -- Zero Divider
        a <= "0000";
        b <= "0000";
        WAIT for 10 ns;

        -- Testcase 3: Trappor
        for K in 0 to 3 loop
            b <= "0000";
            a(K) <= '1';
            for L in 0 to 3 loop
                b(L) <= '1';
                WAIT for 10 ns;
            end loop;
        end loop;

        -- Zero Divider
        a <= "0000";
        b <= "0000";
        WAIT for 10 ns;

        -- Testcase 4: Walking 1:s
        for K in 0 to 3 loop
            a(K) <= '1';
            for L in 0 to 3 loop
                b(L) <= '1';
                WAIT for 10 ns;
                b(L) <= '0';
            end loop;
            a(K) <= '0';
        end loop;


    END PROCESS;

END arithmictest;