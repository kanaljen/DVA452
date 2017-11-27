LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY AdderBlock IS
    PORT ( adderA : in STD_LOGIC;   -- first input for the full adder
           adderB : in STD_LOGIC;   -- second imput for the full adder
           andA : in STD_LOGIC;     -- first input for the and gate
           andB : in STD_LOGIC;     -- second imput for the and gate
           sum : out STD_LOGIC;     -- the sum output
           carry : out STD_LOGIC);  -- the carry output
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
