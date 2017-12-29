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

    signal s_x: STD_LOGIC_VECTOR(M-1 DOWNTO 0);
    signal s_y: STD_LOGIC_VECTOR(M-1 DOWNTO 0);

begin
   
   s_x <= STD_LOGIC_VECTOR(x((M+M-2) DOWNTO (M+M-2)-(M-1)));
   
   s_y <= s_x;
   
--   s_y <= "01111111" when (s_x = "01111111") else
--          "00000100" when (s_x = "00000010") else
--          (others => '0');
   
   y <= SIGNED(s_y);
   
   
   --y <= x(7 downto 0);
   
end NN;