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
        GENERIC(N : INTEGER := 16);
        PORT( a, b: in  STD_LOGIC_VECTOR  (N-1  DOWNTO  0);       
              p : out  STD_LOGIC_VECTOR  (N+N-1  DOWNTO  0)); 
    END component; 

    -- intermediate signal declaration
    signal a ,b : STD_LOGIC_VECTOR  (3  DOWNTO  0);
    signal p : STD_LOGIC_VECTOR  (7  DOWNTO  0);

BEGIN
    
    -- instantiation of component
    multi: multiplier   generic map(N => 4)
                        port map (  a => a,
                                    b => b, 
                                    p => p);


    PROCESS

        BEGIN
        
        

        -- Testcase 1, all zero
        a <= "0100";
        b <= "1010";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "0100";
        b <= "1100";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "0100";
        b <= "1110";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "1000";
        b <= "1000";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "0000";
        b <= "1100";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "1110";
        b <= "1000";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "0100";
        b <= "1010";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "0110";
        b <= "1110";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "1110";
        b <= "1110";
        WAIT for 10 ns;
        -- Testcase 1, all zero
        a <= "1111";
        b <= "0010";
        WAIT for 10 ns;

    END PROCESS;

END arithmictest;