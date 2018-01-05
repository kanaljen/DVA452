LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.adder_Package.all;

PACKAGE LUT_PACKAGE IS


COMPONENT LUT
      PORT (x: IN SIGNED(M+M-1 DOWNTO 0);
            y: OUT SIGNED(M-1 DOWNTO 0));
end component;

end package;

-----------------------------------
----------NODE---------------------
-----------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;

use work.LUT_PACKAGE.all;
use work.adder_Package.all;
use work.mac_Package.all;

entity LUT is
      PORT (x: IN SIGNED(M+M-1 DOWNTO 0);
      y: OUT SIGNED(M-1 DOWNTO 0));
end LUT;

architecture NN of LUT is

    SIGNAL s_x : STD_LOGIC_VECTOR(M-1 DOWNTO 0);
    SIGNAL s_y : STD_LOGIC_VECTOR(M-1 DOWNTO 0);

begin
    -- Truncates the x input erasing the top 8 and bottom 8 bits of the input
    PROCESS(x)
    VARIABLE v_x: SIGNED(M-1 DOWNTO 0) := (others => '0'); -- Temp x variable
    BEGIN
        v_x := x(23 DOWNTO 8);          -- Assigns the truncated input
        IF(x(x'high) = '0') THEN        -- Checks if the value is positive
            FOR i IN 24 TO 30 LOOP      -- If so and if there is a '1' in the upper erased section
                IF(x(i) = '1') THEN     -- adds a 1 at the 2nd most signigficant bit in the truncated section
                    v_x(M-2) := '1';
                    v_x(M-1) := '0';    -- Also adds a zero at the most significant bit to make sure it stays positive        
                END IF;
            END LOOP;
        ELSE
            FOR i IN 24 TO 30 LOOP      -- Same as above but for negatives
                IF(x(i) = '0') THEN
                    v_x(M-2) := '0';
                    v_x(M-1) := '1';
                END IF;
            END LOOP;
        END IF;        
        s_x <= STD_LOGIC_VECTOR(v_x);   -- Assigns the variable to the s_x signal cast as STD_LOGIC_VECTOR for the LUT to work
    END PROCESS;
    
    --------------------------------------------------
    -- The actual LUT
    -- When s_x is the most negative assigns zero to s_y
    -- Then increase s_y as s_x goes to zero and further from zero to the largest positive
    --------------------------------------------------
    s_y <=  "0000001000000000" when s_x = "0001001100000000" else
            "0000001100000000" when s_x = "0001001000000000" else
            "0000000000000101" when s_x = "0000010100000000" else
            "0000001000000000" when s_x = "0000001100000000" else
            "0000001000000000" when s_x = "0000010000000000" else
            "0000001000000000" when s_x = "0000010100000000" else
            (others => '0');
    
    -- Assigns the y output as the casted signed of s_y
    -- I.e. the truncated value from the sigmoid function
    y <= signed(s_y);
   
end NN;