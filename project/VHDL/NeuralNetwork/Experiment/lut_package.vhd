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

    signal s_x1: STD_LOGIC_VECTOR(M+M-1 DOWNTO 0);
    
    signal s_y1: STD_LOGIC_VECTOR(M+M-1 DOWNTO 0);
    signal s_y2: STD_LOGIC_VECTOR(M-1 DOWNTO 0);
begin

    s_x1 <= std_logic_vector(x);

    s_y1 <= "01000000" when (s_x1 = "00000000") else
            "01100000" when (s_x1 = "00000001") else
            "00000010" when (s_x1 = "01100000") else
           (others => '0');


process(s_y1)
begin
    s_y2 <= s_y1(M-1 downto 0);
    
    for i in M+M-1 downto M loop
        if(s_y1(i) = '1') then
            s_y2 <= (others => '1');
        end if;
    end loop;
end process;

end NN;