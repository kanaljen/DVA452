LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.adder_package.all;

PACKAGE MAC_Package IS
COMPONENT MAC_Unit is
    GENERIC (size : INTEGER := c_size);
    PORT( xIn, weightIN: IN SIGNED (size-1 DOWNTO 0);
          acc: IN SIGNED(size+size-1 DOWNTO 0);
          clk, rst: IN STD_LOGIC;
          weightOUT: OUT SIGNED (size-1 DOWNTO 0);
          sum: OUT SIGNED (size+size-1 DOWNTO 0));
END COMPONENT MAC_Unit;

FUNCTION truncate (SIGNAL a, b: SIGNED; size: INTEGER) RETURN SIGNED;
FUNCTION convPosToNeg(SIGNAl a: SIGNED; size: integer) RETURN SIGNED;
FUNCTION truncateSingle (SIGNAL a: SIGNED; size: integer) RETURN SIGNED;

END PACKAGE MAC_Package;
------------------- Package body declarations
PACKAGE BODY MAC_Package IS
FUNCTION truncate (SIGNAL a, b: SIGNED; size: integer) RETURN SIGNED IS
VARIABLE result: SIGNED(size downto 0);
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
FUNCTION convPosToNeg(SIGNAL a: SIGNED; size: integer)RETURN SIGNED IS
 VARIABLE result: SIGNED(size downto 0);
 VARIABLE b: UNSIGNED(size downto 0);
 BEGIN
     b := UNSIGNED(a);
     b := b-1;
     for i in 0 to b'high loop
         if(b(i) = '1') then
             result(i) := '0';
         else
             result(i):= '1';
         end if;
     end loop;
     return  result;
 END FUNCTION convPosToNeg; 
 FUNCTION truncateSingle (SIGNAL a: SIGNED; size: integer) RETURN SIGNED IS
 VARIABLE result: SIGNED(size downto 0);
     BEGIN   
         result := a;
         if(a(a'high) = '1') then
            result := "1000";
         else
            result := "0111";
         end if;       
     return result;
 END function truncateSingle;
end package body MAC_Package;