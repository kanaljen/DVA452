library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------
----------------- Multiplier -----------------
----------------------------------------------

entity multiplier is 
	port( a ,b : in STD_LOGIC_VECTOR  (3  DOWNTO  0);       
		  p : out STD_LOGIC_VECTOR  (7  DOWNTO  0)); 
end multiplier; 

architecture dataflow of multiplier is
	
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

	-- intermediate signal declaration
    signal is03_12,is02_11,is01_10 : STD_LOGIC; 						 -- first row
    signal is13_22,is12_22,is12_21,is11_21,is11_20,is10_20 : STD_LOGIC; -- second row
    signal is23_32,is22_32,is22_31,is21_31,is21_30,is20_30 : STD_LOGIC; -- third row
    signal is33_42,is32_42,is32_41,is31_41,is31_40,is30_40 : STD_LOGIC; -- fourth row
    signal is41_42,is40_41 : STD_LOGIC; -- last row
    signal nil : STD_LOGIC; -- ZERO signal

begin
	
	nil <= '0'; -- Null signal

	------------------------------------------------
	------------------- AND-gates ------------------
	------------------------------------------------

	-- AND_00
	p(0) <= a(0) and b(0);

	-- AND_01
	is01_10 <= a(0) and b(1);

	-- AND_02
	is02_11 <= a(0) and b(2);

	-- AND_03
	is02_11 <= a(0) and b(3);

	-- AND_13
	is13_22 <= a(1) and b(3);

	-- AND_23
	is23_32 <= a(2) and b(3);

	-- AND_33
	is33_42 <= a(3) and b(3);

	------------------------------------------------
	-- Instantiation of the AdderBlock component ---
	------------------------------------------------

	AB_10 : AdderBlock PORT MAP(adderA => is01_10, 
								adderB => nil, 
								andA => a(1), 
								andB => b(0), 
								sum => p(1),
								carry => is10_20);

	AB_11 : AdderBlock PORT MAP(adderA => is02_11, 
								adderB => nil, 
								andA => a(1), 
								andB => b(1), 
								sum => is11_20,
								carry => is11_21);

	AB_12 : AdderBlock PORT MAP(adderA => is03_12, 
								adderB => nil, 
								andA => a(1), 
								andB => b(2), 
								sum => is12_21,
								carry => is12_22);

	AB_20 : AdderBlock PORT MAP(adderA => is11_20, 
								adderB => is10_20, 
								andA => a(2), 
								andB => b(0), 
								sum => p(2),
								carry => is20_30);

	AB_21 : AdderBlock PORT MAP(adderA => is12_21, 
								adderB => is11_21, 
								andA => a(2), 
								andB => b(1), 
								sum => is21_30,
								carry => is21_31);

	AB_22 : AdderBlock PORT MAP(adderA => is13_22, 
								adderB => is12_22, 
								andA => a(2), 
								andB => b(2), 
								sum => is22_31,
								carry => is22_32);

	AB_30 : AdderBlock PORT MAP(adderA => is21_30, 
								adderB => is20_30, 
								andA => a(3), 
								andB => b(0), 
								sum => p(3),
								carry => is30_40);

	AB_31 : AdderBlock PORT MAP(adderA => is22_31, 
								adderB => is21_31, 
								andA => a(3), 
								andB => b(1), 
								sum => is31_40,
								carry => is31_41);

	AB_32 : AdderBlock PORT MAP(adderA => is23_32, 
								adderB => is22_32, 
								andA => a(3), 
								andB => b(2), 
								sum => is32_41,
								carry => is32_42);

	------------------------------------------------
	-- Instantiation of the full_adder component ---
	------------------------------------------------
	
	FA_40 : full_adder PORT MAP(A => is31_40,
								B => nil,
								CIN => is30_40,
								COUT => is40_41, ----------- ?????????
								S => p(4));   	 ----------- ?????????

	FA_41 : full_adder PORT MAP(A => is32_41,
								B => is40_41,
								CIN => is30_40,
								COUT => is41_42, ----------- ?????????
								S => p(5));   	 ----------- ?????????

	FA_42 : full_adder PORT MAP(A => is33_42,
								B => is32_42,
								CIN => is41_42,
								COUT => p(7), ----------- ?????????
								S => p(6));   	 ----------- ?????????
	


end dataflow; -- dataflow