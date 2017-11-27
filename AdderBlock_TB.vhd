library IEEE;
use IEEE.Std_logic_1164.all;

---------------
ENTITY testbench IS
END testbench;

ARCHITECTURE signaltest OF testbench IS

    component AdderBlock is
        Port ( adderA : in STD_LOGIC;
               adderB : in STD_LOGIC;
               andA : in STD_LOGIC;
               andB : in STD_LOGIC;
               sum : out STD_LOGIC;
               carry : out STD_LOGIC);
    end component;

    -- signal declaration
    signal adderA : STD_LOGIC;
    signal adderB : STD_LOGIC;
    signal andA : STD_LOGIC;
    signal andB : STD_LOGIC;
    signal sum : STD_LOGIC; 
    signal carry : STD_LOGIC; 

BEGIN

    adderBlock1: AdderBlock port map (adderA, adderB, andA, andB, sum, carry);

    PROCESS

        BEGIN
        -- 160 ns test
        -- testcase 1
        adderA <= '0';
        adderB <= '0';
        andA <= '0';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 2
        adderA <= '0';
        adderB <= '0';
        andA <= '0';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 3
        adderA <= '0';
        adderB <= '0';
        andA <= '1';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 4
        adderA <= '0';
        adderB <= '0';
        andA <= '1';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 5
        adderA <= '0';
        adderB <= '1';
        andA <= '0';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 6
        adderA <= '0';
        adderB <= '1';
        andA <= '0';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 7
        adderA <= '0';
        adderB <= '1';
        andA <= '1';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 8
        adderA <= '0';
        adderB <= '1';
        andA <= '1';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 9
        adderA <= '1';
        adderB <= '0';
        andA <= '0';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 10
        adderA <= '1';
        adderB <= '0';
        andA <= '0';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 11
        adderA <= '1';
        adderB <= '0';
        andA <= '1';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 12
        adderA <= '1';
        adderB <= '0';
        andA <= '1';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 13
        adderA <= '1';
        adderB <= '1';
        andA <= '0';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 14
        adderA <= '1';
        adderB <= '1';
        andA <= '0';
        andB <= '1';
        WAIT for 10 ns;

        -- testcase 15
        adderA <= '1';
        adderB <= '1';
        andA <= '1';
        andB <= '0';
        WAIT for 10 ns;

        -- testcase 15
        adderA <= '1';
        adderB <= '1';
        andA <= '1';
        andB <= '1';
        WAIT for 10 ns;
  
    END PROCESS;

END signaltest;