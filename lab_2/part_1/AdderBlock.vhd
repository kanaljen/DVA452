LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY AdderBlock IS
    PORT ( adderA : in STD_LOGIC;
           adderB : in STD_LOGIC;
           andA : in STD_LOGIC;
           andB : in STD_LOGIC;
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
END AdderBlock;

ARCHITECTURE adderBlockDataFlow of AdderBlock IS
    
    COMPONENT full_adder IS
    PORT ( A :     in STD_LOGIC;         -- First input
           B :     in STD_LOGIC;         -- Second input
           CIN :in STD_LOGIC;         -- Carry in
           COUT : out STD_LOGIC;     -- Carry out
           S : out STD_LOGIC);         -- Adder out);
    END COMPONENT;
    
    signal q1 : STD_LOGIC;

begin
    q1 <= andA AND andB;
    
    G1 : full_adder PORT MAP(adderA, adderB, q1, carry, sum);

    

end adderBlockDataFlow;
