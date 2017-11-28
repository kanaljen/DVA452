LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
PACKAGE my_package_lab2 IS
COMPONENT MAC_UNIT is
    PORT( a, b: IN SIGNED (7 DOWNTO 0);
        sum: OUT SIGNED (7 DOWNTO 0));
END COMPONENT MAC_UNIT;

FUNCTION truncate (SIGNAL a, b: SIGNED; size: integer) RETURN SIGNED;

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

end package body my_package_lab2;