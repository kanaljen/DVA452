LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.adder_Package.all;

PACKAGE OUTPUT_NODE_PACKAGE IS

COMPONENT OUTPUT_NODE
      PORT (x: IN INPUTARRAY;
            clk, rst: IN STD_LOGIC;
            y: OUT INPUTARRAY);
end component;

end package;

-----------------------------------
----------NODE---------------------
-----------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.NODE_Package.all;
use work.MAC_Package.all;
use work.adder_package.all;
use work.LUT_package.all;
use work.OUTPUT_NODE_PACKAGE.all;

entity OUTPUT_NODE is
      PORT (x: IN INPUTARRAY;
      clk, rst: IN STD_LOGIC;
      y: OUT INPUTARRAY);
end OUTPUT_NODE;

architecture NN of OUTPUT_NODE is

--SIGNAL output_index : INTEGER;
SIGNAL sum : INPUTARRAY;

begin

sum <= x;
y <= sum;
    
--y <= output_index;

--    PROCESS (x)
--    VARIABLE output_value : SIGNED(M-1 DOWNTO 0);
--    BEGIN
--        output_value := x(0);
--        output_index <= 0;
--        for i in 1 to K-1 loop
--            IF(x(i) > output_value) THEN
--                output_value := x(i);
--                output_index <= i;
--            END IF;
--        end loop;
--    END PROCESS;

end NN;