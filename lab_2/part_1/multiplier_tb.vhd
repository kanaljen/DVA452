
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
        -- 80 ns test
        -- testcase 1 (2*2=4)
        a <= "0010";
        b <= "0010";
        WAIT for 10 ns;

        -- testcase 2 (4*4=16)
        a <= "0100";
        b <= "0100";
        WAIT for 10 ns;

        -- testcase 3 (0*0=0)
        a <= "0000";
        b <= "0000";
        WAIT for 10 ns;


    END PROCESS;

END arithmictest;