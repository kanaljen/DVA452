LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
PACKAGE my_package_lab2 IS
COMPONENT MAC_UNIT is
    PORT( a, b: IN SIGNED;
        sum: OUT SIGNED);
END COMPONENT MAC_UNIT;

COMPONENT multiplier IS
    PORT( a ,b : in STD_LOGIC_VECTOR;       
		  p : out STD_LOGIC_VECTOR); 
END COMPONENT multiplier;

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

FUNCTION truncate (SIGNAL a, b: SIGNED; size: INTEGER) RETURN SIGNED;
FUNCTION multiply (SIGNAL a, b: SIGNED) RETURN SIGNED;
FUNCTION fullAdder (a, b, cin: STD_LOGIC) RETURN STD_LOGIC_VECTOR;
FUNCTION addBlock (adderA, adderB, andA, andB: STD_LOGIC) RETURN STD_LOGIC_VECTOR;

END PACKAGE my_package_lab2;
------------------- Package body declarations
PACKAGE BODY my_package_lab2 IS
FUNCTION truncate (SIGNAL a, b: SIGNED; size: integer) RETURN SIGNED IS
VARIABLE result: SIGNED(size downto 0);
VARIABLE carry: STD_LOGIC;
    BEGIN   
        result := a + b;
        if(a(a'high) = b(b'high)) then
            if(result(result'high) /= a(a'high)) then
                if(a(a'high) = '0') then
                    result := (result'high => '0', others => '1');
                   -- result := "01111111";
                else
                    result := (result'high => '1', others => '0');
                    --result := "10000000";
                end if;
            end if;
        end if;       
    return result;
END function truncate;

FUNCTION multiply (SIGNAL a, b: SIGNED) RETURN SIGNED IS
VARIABLE is03_12,is02_11,is01_10 : STD_LOGIC; 						 -- first row
VARIABLE is13_22,is12_22,is12_21,is11_21,is11_20,is10_20 : STD_LOGIC; -- second row
VARIABLE is23_32,is22_32,is22_31,is21_31,is21_30,is20_30 : STD_LOGIC; -- third row
VARIABLE is33_42,is32_42,is32_41,is31_41,is31_40,is30_40 : STD_LOGIC; -- fourth row
VARIABLE is41_42,is40_41 : STD_LOGIC; -- last row
VARIABLE nil : STD_LOGIC; -- ZERO signal
VARIABLE sum_AB_10, sum_AB_11, sum_AB_12: STD_LOGIC_VECTOR(1 DOWNTO 0); -- sum of an addBlock (0) = sum, (1) = carry
VARIABLE sum_AB_20, sum_AB_21, sum_AB_22: STD_LOGIC_VECTOR(1 DOWNTO 0);
VARIABLE sum_AB_30, sum_AB_31, sum_AB_32: STD_LOGIC_VECTOR(1 DOWNTO 0);
VARIABLE sum_FA_40, sum_FA_41, sum_FA_42: STD_LOGIC_VECTOR(1 DOWNTO 0);
VARIABLE p : SIGNED(7 DOWNTO 0);
    BEGIN
    nil := '0'; -- Null signal

    ------------------------------------------------
    ------------------- AND-gates ------------------
    ------------------------------------------------

    -- AND_00
    p(0) := a(0) and b(0);

    -- AND_01
    is01_10 := a(0) and b(1);

    -- AND_02
    is02_11 := a(0) and b(2);

    -- AND_03
    is03_12 := a(0) and b(3);

    -- AND_13
    is13_22 := a(1) and b(3);

    -- AND_23
    is23_32 := a(2) and b(3);

    -- AND_33
    is33_42 := a(3) and b(3);

    ------------------------------------------------
    -- Instantiation of the AdderBlock component ---
    ------------------------------------------------

    sum_AB_10 := addBlock(is01_10, nil, a(1), b(0));
    p(1) := sum_AB_10(0);
    is10_20 := sum_AB_10(1);
    sum_AB_11 := addBlock(is02_11, nil, a(1), b(1));
    is11_20 := sum_AB_11(0);
    is11_21 := sum_AB_11(1);
    sum_AB_12 := addBlock(is03_12, nil, a(1), b(2));
    is12_21 := sum_AB_12(0);
    is12_22 := sum_AB_12(1);
    
--    AB_10 : AdderBlock PORT MAP(adderA => is01_10, 
--                                adderB => nil, 
--                                andA => a(1), 
--                                andB => b(0), 
--                                sum => p(1),
--                                carry => is10_20);

--    AB_11 : AdderBlock PORT MAP(adderA => is02_11, 
--                                adderB => nil, 
--                                andA => a(1), 
--                                andB => b(1), 
--                                sum => is11_20,
--                                carry => is11_21);

--    AB_12 : AdderBlock PORT MAP(adderA => is03_12, 
--                                adderB => nil, 
--                                andA => a(1), 
--                                andB => b(2), 
--                                sum => is12_21,
--                                carry => is12_22);
                                
    sum_AB_20 := addBlock(is11_20, is10_20, a(2), b(0));
    p(2) := sum_AB_20(0);
    is20_30 := sum_AB_20(1);    
    sum_AB_21 := addBlock(is12_21, is11_21, a(2), b(1));
    is21_30 := sum_AB_21(0); 
    is21_31 := sum_AB_21(1); 
    sum_AB_22 := addBlock(is13_22, is12_22, a(2), b(2));
    is22_31 := sum_AB_22(0); 
    is22_32 := sum_AB_22(1); 
    
--    AB_20 : AdderBlock PORT MAP(adderA => is11_20, 
--                                adderB => is10_20, 
--                                andA => a(2), 
--                                andB => b(0), 
--                                sum => p(2),
--                                carry => is20_30);

--    AB_21 : AdderBlock PORT MAP(adderA => is12_21, 
--                                adderB => is11_21, 
--                                andA => a(2), 
--                                andB => b(1), 
--                                sum => is21_30,
--                                carry => is21_31);

--    AB_22 : AdderBlock PORT MAP(adderA => is13_22, 
--                                adderB => is12_22, 
--                                andA => a(2), 
--                                andB => b(2), 
--                                sum => is22_31,
--                                carry => is22_32);

sum_AB_30 := addBlock(is21_30, is20_30, a(3), b(0));
p(3) := sum_AB_30(0); 
is30_40 := sum_AB_30(1); 
sum_AB_31 := addBlock(is22_31, is21_31, a(3), b(1));
is31_40 := sum_AB_31(0); 
is31_41 := sum_AB_31(1); 
sum_AB_32 := addBlock(is23_32, is22_32, a(3), b(2));
is32_41 := sum_AB_32(0); 
is32_42 := sum_AB_32(1); 

--    AB_30 : AdderBlock PORT MAP(adderA => is21_30, 
--                                adderB => is20_30, 
--                                andA => a(3), 
--                                andB => b(0), 
--                                sum => p(3),
--                                carry => is30_40);

--    AB_31 : AdderBlock PORT MAP(adderA => is22_31, 
--                                adderB => is21_31, 
--                                andA => a(3), 
--                                andB => b(1), 
--                                sum => is31_40,
--                                carry => is31_41);

--    AB_32 : AdderBlock PORT MAP(adderA => is23_32, 
--                                adderB => is22_32, 
--                                andA => a(3), 
--                                andB => b(2), 
--                                sum => is32_41,
--                                carry => is32_42);

    ------------------------------------------------
    -- Instantiation of the full_adder component ---
    ------------------------------------------------
    sum_FA_40 := fullAdder(is31_40, nil, is30_40);
    p(4) := sum_FA_40(0); 
    is40_41 := sum_FA_40(1); 
    sum_FA_41 := fullAdder(is32_41, is31_41, is40_41);
    p(5) := sum_FA_40(0); 
    is41_42 := sum_FA_40(1); 
    sum_FA_42 := fullAdder(is33_42, is32_42, is41_42);
    p(6) := sum_FA_40(0); 
    p(7) := sum_FA_40(1); 
    
--    FA_40 : full_adder PORT MAP(A => is31_40,
--                                B => nil,
--                                CIN => is30_40,
--                                COUT => is40_41, ----------- ?????????
--                                S => p(4));        ----------- ?????????

--    FA_41 : full_adder PORT MAP(A => is32_41,
--                                B => is31_41,
--                                CIN => is40_41,
--                                COUT => is41_42, ----------- ?????????
--                                S => p(5));        ----------- ?????????

--    FA_42 : full_adder PORT MAP(A => is33_42,
--                                B => is32_42,
--                                CIN => is41_42,
--                                COUT => p(7), ----------- ?????????
--                                S => p(6));        ----------- ?????????
                            
    RETURN p;
END FUNCTION multiply;

FUNCTION fullAdder (a, b, cin: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
VARIABLE S : STD_LOGIC_VECTOR(1 DOWNTO 0);  
VARIABLE q1, q2, q3 : STD_LOGIC;
    BEGIN
    	-- internal signals
    q1 := A xor B;
    q2 := q1 and CIN;
    q3 := A and B;

    -- output
    S(0) := q1 xor CIN;
    S(1) := q2 or q3;
    RETURN S;
END FUNCTION fullAdder;

FUNCTION addBlock (adderA, adderB, andA, andB: STD_LOGIC) RETURN STD_LOGIC_VECTOR IS
VARIABLE q1 : STD_LOGIC;
VARIABLE sum : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
    q1 := andA AND andB;
    sum := fullAdder(adderA, adderB, q1);
    return sum;
END FUNCTION addBlock;

end package body my_package_lab2;