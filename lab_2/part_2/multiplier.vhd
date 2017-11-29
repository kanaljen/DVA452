library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.all;

----------------------------------------------
----------------- Multiplier -----------------
----------------------------------------------

entity multiplier is
    generic(N : INTEGER := 16);
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

type matrix is array (0 to N-1) of STD_LOGIC_VECTOR(N-1 downto 0); 
signal sumIn : matrix;
signal carryIn : matrix;
signal sum : matrix;
signal carry : matrix;

signal bottomSumIn : STD_LOGIC_VECTOR(0 to N-1);
signal bottomSumOut : STD_LOGIC_VECTOR(0 to N-1);
signal bottomCarryIn : STD_LOGIC_VECTOR(0 to N-1);
signal bottomCarryOut : STD_LOGIC_VECTOR(0 to N-1);
signal bottomCarryIn2 : STD_LOGIC_VECTOR(0 to N-1);

begin
	
    b_loop : for i in 0 to N-1 generate
        a_loop : for j in 0 to N-1 generate
            AB : AdderBlock PORT MAP(adderA => sumIn(i)(j), 
                                     adderB => carryIn(i)(j),
                                     andA => a(i),
                                     andB => b(j),
                                     sum => sum(i)(j),
                                     carry => carry(i)(j));
        end generate;
    end generate;
    
    final_row_loop : for j in 0 to N-2 generate
        bottomAdders : AdderBlock PORT MAP(   adderA => bottomSumIn(j), 
                                        adderB => bottomCarryIn(j),
                                        andA => bottomCarryIn2(j),
                                        andB => bottomCarryIn2(j),
                                        sum => bottomSumOut(j),
                                        carry => bottomCarryOut(j));
    end generate;
    
    -- Initializes all carry ins on the top most adderblocks
    init_carryIn : for j in 0 to N-1 generate
        sumIn(0)(j) <= '0';
    end generate;
    
    -- Sets the connection for all sum ins as the upper left adjecent adderblock
    carryIn_a_loop : for i in 1 to N-1 generate
        carryIn_b_loop : for j in 0 to N-2 generate
            sumIn(i)(j) <= sum(i-1)(j+1);
        end generate;
        sumIn(i)(N-1) <= '0'; -- Sets the left most adderblocks sum in to 0
    end generate;
    
    -- Sets all carry ins to the upper adjecent adderblock carry out
    sumIn_a_loop : for j in 0 to N-1 generate
        carryIn(0)(j) <= '0';                   -- sets the uppermost adderblcks carry in to 0
        sumIn_b_loop : for i in 1 to N-1 generate
            carryIn(i)(j) <= carry(i-1)(j);
        end generate;
    end generate;
    
    --  Sets product out to sum out om the coresponding adderblock upp to N-1
    p_a_loop : for i in 0 to N-1 generate
        p(i) <= sum(i)(0);
    end generate;
    
    -- sets the second carry in on the bottom adderblocks to the right carry out
    bottomCarryIn2(0) <= '0';                       -- Sets the ritghtmost adderblocks second carry in to 0
    bottom_carry_loop : for j in 1 to N-2 generate
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