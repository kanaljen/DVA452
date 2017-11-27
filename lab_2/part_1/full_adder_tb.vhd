
library IEEE;
use IEEE.Std_logic_1164.all;

---------------
ENTITY testbench IS
END testbench;

ARCHITECTURE signaltest OF testbench IS

    component full_adder is
        Port ( A :  in STD_LOGIC;       -- First input
               B :  in STD_LOGIC;       -- Second input
               CIN : in STD_LOGIC;      -- Carry in
               COUT : out STD_LOGIC;    -- Carry out
               S : out STD_LOGIC);      -- Adder out
    end component;

    -- signal declaration
    signal A : STD_LOGIC;
    signal B : STD_LOGIC;
    signal CIN : STD_LOGIC;
    signal COUT : STD_LOGIC;
    signal S : STD_LOGIC; 

BEGIN

    full_adder_ports: full_adder port map (A, B, CIN, COUT,S);

    PROCESS

        BEGIN
        -- 80 ns test
        -- testcase 1
        A <= '0';
        B <= '0';
        CIN <= '0';
        WAIT for 10 ns;

        -- testcase 2
        A <= '1';
        B <= '0';
        CIN <= '0';
        WAIT for 10 ns;

        -- testcase 3
        A <= '0';
        B <= '1';
        CIN <= '0';
        WAIT for 10 ns;

        -- testcase 4
        A <= '1';
        B <= '1';
        CIN <= '0';
        WAIT for 10 ns;

        -- testcase 5
        A <= '0';
        B <= '0';
        CIN <= '1';
        WAIT for 10 ns;

        -- testcase 6
        A <= '1';
        B <= '0';
        CIN <= '1';
        WAIT for 10 ns;

        -- testcase 7
        A <= '0';
        B <= '1';
        CIN <= '1';
        WAIT for 10 ns;

        -- testcase 8
        A <= '1';
        B <= '1';
        CIN <= '1';
        WAIT for 10 ns;

    END PROCESS;

END signaltest;