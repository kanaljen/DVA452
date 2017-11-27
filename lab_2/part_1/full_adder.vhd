library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( A : 	in STD_LOGIC; 		-- First input
           B : 	in STD_LOGIC; 		-- Second input
           CIN :in STD_LOGIC; 		-- Carry in
           COUT : out STD_LOGIC; 	-- Carry out
           S : out STD_LOGIC); 		-- Adder out
end full_adder;


architecture dataflow of full_adder is

	signal q1, q2, q3 : STD_LOGIC;

begin
	
	-- internal signals
	q1 <= A xor B;
	q2 <= q1 and CIN;
	q3 <= A and B;

	-- output
	S <= q1 xor CIN;
	COUT <= q2 or q3;

end architecture ; -- dataflow