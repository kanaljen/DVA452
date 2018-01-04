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

    PROCESS(x)
    VARIABLE v_x: SIGNED(M-1 DOWNTO 0) := (others => '0');
    BEGIN
        v_x := x(23 DOWNTO 8);
        IF(x(x'high) = '0') THEN
            FOR i IN 24 TO 30 LOOP
                IF(x(i) = '1') THEN
                    v_x(M-2) := '1';
                    v_x(M-1) := '0';                    
                END IF;
            END LOOP;
        ELSE
            FOR i IN 24 TO 30 LOOP
                IF(x(i) = '0') THEN
                    v_x(M-2) := '0';
                    v_x(M-1) := '1';
                END IF;
            END LOOP;
        END IF;        
        s_x <= STD_LOGIC_VECTOR(v_x);
    END PROCESS;
    
    s_y <=  "0000000000000010" when s_x = "0001001100000000" else
            "0000000000000011" when s_x = "0001001000000000" else
            "0000001000000000" when s_x = "0000001100000000" else
            "0000001000000000" when s_x = "0000010000000000" else
            "0000001000000000" when s_x = "0000010100000000" else
            (others => '0');
    
    y <= signed(s_y);
   
end NN;