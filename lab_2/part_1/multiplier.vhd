library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------
----------------- Multiplier -----------------
----------------------------------------------

ENTITY multiplier  IS 
	PORT( A,  B:  IN  STD_LOGIC_VECTOR  (3  DOWNTO  0);       
		  PROD:  OUT  STD_LOGIC_VECTOR  (7  DOWNTO  0)); 
END multiplier; 

architecture dataflow of multiplier is

    component full_adder is
        Port ( A :  in STD_LOGIC;       -- First input
               B :  in STD_LOGIC;       -- Second input
               CIN : in STD_LOGIC;      -- Carry in
               COUT : out STD_LOGIC;    -- Carry out
               S : out STD_LOGIC);      -- Adder out
    end component;

	component AdderBlock is
	    port ( adderA : in STD_LOGIC;   -- first input for the full adder
	           adderB : in STD_LOGIC;   -- second imput for the full adder
	           andA : in STD_LOGIC;     -- first input for the and gate
	           andB : in STD_LOGIC;     -- second imput for the and gate
	           sum : out STD_LOGIC;     -- the sum output
	           carry : out STD_LOGIC);  -- the carry output
	end component;

begin

end architecture ; -- dataflow