library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.adder_package.all;
use work.MAC_Package.all;

entity MAC_Unit is
    GENERIC (size : INTEGER := c_size);
    PORT( xIn, coef: IN SIGNED (size-1 DOWNTO 0);
          acc: IN SIGNED(size+size-1 DOWNTO 0);
          clk, rst: IN STD_LOGIC := '0';
          q: OUT SIGNED (size-1 DOWNTO 0) := (others => '0');
          sum: OUT SIGNED (size+size-1 DOWNTO 0));
end MAC_Unit;

architecture Behavioral of MAC_Unit is
    SIGNAL prod: SIGNED (size+size-1 DOWNTO 0);
    SIGNAL prodSum: SIGNED (size+size-1 DOWNTO 0);
    SIGNAL xInU : SIGNED(size-1 DOWNTO 0);   -- SIGNAL for convert negative number to positive
    SIGNAL coefU : SIGNED (size-1 DOWNTO 0);   -- SIGNAL for convert negative number to positive
    
begin

    muli : multiplier port map (a => xInU,
                                    b => coefU,
                                    p => prod);

    -- Convert negative number to positive
    PROCESS (xIn, coef)
    BEGIN
        -- If the most significant bit in xIn is a one the whole xIn is converted
        IF(xIn(xIn'high) = '1') THEN
            xInU <= convPosToNeg(xIn, size-1);
        ELSE
            xInU  <= xIn;
        END IF;
        -- If the most significant bit in coef is a one the whole coef is converted
        IF(coef(coef'high) = '1') THEN
            coefU <= convPosToNeg(coef, size-1);
        ELSE
            coefU <= coef;
        END IF;
    END PROCESS;
    
    -- Sets the prodSum
    PROCESS(prod, xIn, coef)
    BEGIN
        -- If the most significant bit in xIn and coef is not the same the 
        -- product should be negative, so the prodSum is converted to negative number
        IF(xIn(xIn'high) /= coef(coef'high)) THEN
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