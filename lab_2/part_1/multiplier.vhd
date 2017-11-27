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

begin

end architecture ; -- dataflow