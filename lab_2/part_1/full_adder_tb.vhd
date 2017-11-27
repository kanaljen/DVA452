
library IEEE;
use IEEE.Std_logic_1164.all;

----------------------------------------------
-------- Testbench for full_adder.vhd --------
----------------------------------------------

ENTITY full_adder_tb IS
END full_adder_tb;

ARCHITECTURE signaltest OF full_adder_tb IS

    component full_adder is
        Port ( A :  in STD_LOGIC;       -- First input
               B :  in STD_LOGIC;       -- Second input
               CIN : in STD_LOGIC;      -- Carry in
               COUT : out STD_LOGIC;    -- Carry out
               S : out STD_LOGIC);      -- Adder out
    end component;

    -- intermediate signal declaration
    signal a : STD_LOGIC;
    signal b : STD_LOGIC;
    signal cin : STD_LOGIC;
    signal cout : STD_LOGIC;
    signal s : STD_LOGIC; 

BEGIN
    
    -- instantiation of component
    fa: full_adder port map (A => a,
                             B => b, 
                             CIN => cin, 
                             COUT => cout,
                             S => s);

    PROCESS

        BEGIN
        -- 80 ns test
        -- testcase 1
        a <= '0';
        b <= '0';
        cin <= '0';
        WAIT for 10 ns;

        -- testcase 2
        a <= '1';
        b <= '0';
        cin <= '0';
        WAIT for 10 ns;

        -- testcase 3
        a <= '0';
        b <= '1';
        cin <= '0';
        WAIT for 10 ns;

        -- testcase 4
        a <= '1';
        b <= '1';
        cin <= '0';
        WAIT for 10 ns;

        -- testcase 5
        a <= '0';
        b <= '0';
        cin <= '1';
        WAIT for 10 ns;

        -- testcase 6
        a <= '1';
        b <= '0';
        cin <= '1';
        WAIT for 10 ns;

        -- testcase 7
        a <= '0';
        b <= '1';
        cin <= '1';
        WAIT for 10 ns;

        -- testcase 8
        a <= '1';
        b <= '1';
        cin <= '1';
        WAIT for 10 ns;

    END PROCESS;

END signaltest;