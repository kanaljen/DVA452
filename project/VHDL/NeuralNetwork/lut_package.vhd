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

begin
    
   y <= x(7 downto 0);
   
end NN;