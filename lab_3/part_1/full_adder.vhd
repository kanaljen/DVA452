library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity voter is
    Generic(N : INTEGER := 15);
    Port ( A : 	in STD_LOGIC_VECTOR(N-1 DOWNTO 0); 		-- First input
           B : 	in STD_LOGIC_VECTOR(N-1 DOWNTO 0); 		-- Second input
           CIN : in STD_LOGIC_VECTOR(N-1 DOWNTO 0); 	-- Carry in
           COUT : out STD_LOGIC_VECTOR(N-1 DOWNTO 0)); 	-- Carry out
end voter;


architecture dataflow of voter is

	signal q1, q2, q3 : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

begin
	
	vote_loop : for i in 0 to N-1 generate
	
	   -- internal signals+
        q1(i) <= A(i) xor B(i);
        q2(i) <= q1(i) and CIN(i);
        q3(i) <= A(i) and B(i);
    
        -- output
        COUT(i) <= q2(i) or q3(i);
	
	end generate;
	

end architecture; -- dataflow