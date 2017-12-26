LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.adder_Package.all;

PACKAGE OUTPUT_NODE_PACKAGE IS

COMPONENT OUTPUT_NODE
      PORT (x: IN INPUTARRAY;
            clk, rst: IN STD_LOGIC;
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
use work.NODE_Package.all;
use work.MAC_Package.all;
use work.adder_package.all;
use work.LUT_package.all;
use work.OUTPUT_NODE_PACKAGE.all;

entity OUTPUT_NODE is
      PORT (x: IN INPUTARRAY;
      clk, rst: IN STD_LOGIC;
      y: OUT SIGNED(M-1 DOWNTO 0));
end OUTPUT_NODE;

architecture NN of OUTPUT_NODE is

begin
    
y <= x(0);

end NN;