library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package adder_package is

constant c_size : INTEGER := 4;
    
component full_adder is
    Port ( A : 	in STD_LOGIC; 		-- First input
           B : 	in STD_LOGIC; 		-- Second input
           CIN :in STD_LOGIC; 		-- Carry in
           COUT : out STD_LOGIC; 	-- Carry out
           S : out STD_LOGIC); 		-- Adder out
end component; 

component AdderBlock IS
    PORT ( adderA : in STD_LOGIC;   -- first input for the full adder
           adderB : in STD_LOGIC;   -- second imput for the full adder
           andA : in STD_LOGIC;     -- first input for the and gate
           andB : in STD_LOGIC;     -- second imput for the and gate
           sum : out STD_LOGIC;     -- the sum output
           carry : out STD_LOGIC);  -- the carry output
end component;

component multiplier IS
    generic(N : INTEGER := c_size);                             -- Sets the multiplier to 16 bit default
    PORT( a ,b : in STD_LOGIC_VECTOR;       
		  p : out STD_LOGIC_VECTOR); 
end component multiplier;

end package adder_package;

----------------------------------------------
-------------- 2-bit full-adder --------------
----------------------------------------------

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

	-- intermediate signal declaration
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

--------------------------------------------
----------------- AdderBlock ---------------
--------------------------------------------

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

----------------------------------------------
----------------- Multiplier -----------------
----------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier is
    generic(N : INTEGER := 4);                             -- Sets the multiplier to 16 bit default
	port( a ,b : in STD_LOGIC_VECTOR  (N-1  DOWNTO  0);       
		  p : out STD_LOGIC_VECTOR  (N+N-1  DOWNTO  0)); 
end multiplier; 

architecture multiarch of multiplier is
	
	-- just the full adder component
    component full_adder is
        Port ( A :  in STD_LOGIC;       -- First input
               B :  in STD_LOGIC;       -- Second input
               CIN : in STD_LOGIC;      -- Carry in
               COUT : out STD_LOGIC;    -- Carry out
               S : out STD_LOGIC);      -- Adder out
    end component;

    -- block with both AND-gate and full adder
	component AdderBlock is
	    port ( adderA : in STD_LOGIC;   -- first input for the full adder
	           adderB : in STD_LOGIC;   -- second imput for the full adder
	           andA : in STD_LOGIC;     -- first input for the and gate
	           andB : in STD_LOGIC;     -- second imput for the and gate
	           sum : out STD_LOGIC;     -- the sum output
	           carry : out STD_LOGIC);  -- the carry output
	end component;

    -- signals for all regular adderblocks defined as matrices
    type matrix is array (0 to N-1) of STD_LOGIC_VECTOR(N-1 downto 0); 
    signal sumIn : matrix;
    signal carryIn : matrix;
    signal sum : matrix;
    signal carry : matrix;
    
    -- input output signals for the bottom adderblocks
    signal bottomSumIn : STD_LOGIC_VECTOR(0 to N-1);
    signal bottomSumOut : STD_LOGIC_VECTOR(0 to N-1);
    signal bottomCarryIn : STD_LOGIC_VECTOR(0 to N-1);
    signal bottomCarryOut : STD_LOGIC_VECTOR(0 to N-1);
    signal bottomCarryIn2 : STD_LOGIC_VECTOR(0 to N-1);

begin
	
	-- generates all regular adderblocks
    a_loop : for i in 0 to N-1 generate
        b_loop : for j in 0 to N-1 generate
            AB : AdderBlock PORT MAP(adderA => sumIn(i)(j), 
                                     adderB => carryIn(i)(j),
                                     andA => a(i),
                                     andB => b(j),
                                     sum => sum(i)(j),
                                     carry => carry(i)(j));
        end generate;
    end generate;
    
    -- generates the bottom most adderblocks which are just basicly adders
    final_row_loop : for j in 0 to N-2 generate
        bottomAB : AdderBlock PORT MAP( adderA => bottomSumIn(j), 
                                        adderB => bottomCarryIn(j),
                                        andA => bottomCarryIn2(j),
                                        andB => bottomCarryIn2(j),
                                        sum => bottomSumOut(j),
                                        carry => bottomCarryOut(j));
    end generate;
    
    -- Initializes all sum ins on the top most adderblocks to 0
    init_sumIn : for j in 0 to N-1 generate
        sumIn(0)(j) <= '0';
    end generate;
    
    -- Sets the connection for all sum ins as the upper left adjecent adderblock
    sumIn_a_loop : for i in 1 to N-1 generate
        sumIn_b_loop : for j in 0 to N-2 generate
            sumIn(i)(j) <= sum(i-1)(j+1);
        end generate;
        sumIn(i)(N-1) <= '0'; -- Sets the left most adderblocks sum in to 0
    end generate;
    
    -- Sets all carry ins to the upper adjecent adderblock carry out
    carryIn_b_loop : for j in 0 to N-1 generate
        carryIn(0)(j) <= '0';                   -- sets the uppermost adderblcks carry in to 0
        carryIn_a_loop : for i in 1 to N-1 generate
            carryIn(i)(j) <= carry(i-1)(j);
        end generate;
    end generate;
    
    --  Sets product out to sum out om the coresponding adderblock upp to N-1
    p_a_loop : for i in 0 to N-1 generate
        p(i) <= sum(i)(0);
    end generate;
    
    -- sets the second carry in on the bottom adderblocks to the right carry out
    bottomCarryIn2(0) <= '0';                       -- Sets the ritghtmost adderblocks second carry in to 0
    bottom_carryIn2_loop : for j in 1 to N-2 generate
            bottomCarryIn2(j) <= carry(N-1)(j-1);
    end generate;

    -- Sets the sum in for the bottom adderblocks to the upper left adjecent adderblock sum out
    -- Sets the carry in for bottom adderblocks to the upper adjecent adderblock carry out
    -- Finally sets the product out to the sum of the coresponding upper adderblock
    p_b_loop : for j in 0 to N-2 generate
            bottomSumIn(j) <= sum(N-1)(j+1);
            bottomCarryIn(j) <= carry(N-1)(j);
            
            p(N+j) <= bottomSumOut(j);
    end generate;
    p(N+N-1) <= bottomCarryOut(N-2); -- Sets the last product bit to the carry out from the leftmost bottom adderblock
	
end architecture; -- multiarch