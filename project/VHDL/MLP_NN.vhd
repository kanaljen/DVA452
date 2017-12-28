library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.node_package.all;
use work.MAC_Package.all;
use work.adder_package.all;

entity MLP_NN is
    GENERIC (size : INTEGER := c_size);
    Port ( xIn : IN SIGNED (size-1 DOWNTO 0);
           weight : IN INPUTARRAY;
           rst : IN STD_LOGIC;
           clk : IN STD_LOGIC;
           y : OUT STD_LOGIC_VECTOR (size-1 downto 0));
end MLP_NN;

architecture Behavioral of MLP_NN is

    SIGNAL prod: SIGNED (size+size-1 DOWNTO 0);
    SIGNAL prodSum: SIGNED (size+size-1 DOWNTO 0);
    SIGNAL xInU : SIGNED(size-1 DOWNTO 0);   -- SIGNAL for convert negative number to positive
    SIGNAL coefU : SIGNED (size-1 DOWNTO 0);   -- SIGNAL for convert negative number to positive
    
begin

    muli : multiplier port map (a => xInU,
                                    b => coefU,
                                    p => prod);

    -- Convert negative number to positive
    PROCESS (xIn, weight)
    BEGIN
        -- If the most significant bit in xIn is a one the whole xIn is converted
        IF(xIn(xIn'high) = '1') THEN
            xInU <= convPosToNeg(xIn, size-1);
        ELSE
            xInU  <= xIn;
        END IF;
        -- If the most significant bit in weight is a one the whole weight is converted
        IF(weightIN(weightIN'high) = '1') THEN
            weightU <= convPosToNeg(weightIN, size-1);
        ELSE
            weightU <= weightIN;
        END IF;
    END PROCESS;
    
    -- Sets the prodSum
    PROCESS(prod, xIn, weight)
    BEGIN
        -- If the most significant bit in xIn and weight is not the same the 
        -- product should be negative, so the prodSum is converted to negative number
        IF(xIn(xIn'high) /= weight(weight'high)) THEN
            prodSum <= convPosToNeg(prod, size+size-1);
        ELSE
            prodSum <= prod; -- if the product is not negative
        END IF;
    END PROCESS;
    
    -- Makes the addition and truncate for larger sums
    PROCESS(prodSum, acc)
    BEGIN
        Sum <= truncate(prodSum,acc, size+size-1); 
    END PROCESS;
    
    -- Flip-Flops the output of the MAC if the clock is high
    -- Resets the flip-flop is rst is one
    PROCESS (clk, rst)
    BEGIN
        IF (rst = '1') THEN
            q <= (others => '0');
        ELSIF (clk'EVENT AND CLK = '1') THEN
            q <= xIn;
        END IF;
    END PROCESS;
END Behavioral;
