LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;

PACKAGE MAC_Package IS
COMPONENT MAC_Unit is
    GENERIC (size : INTEGER := 4);
    PORT( a, b: IN STD_LOGIC_VECTOR (size-1 DOWNTO 0);
        clk, rst: IN STD_LOGIC;
        acc: OUT STD_LOGIC_VECTOR (size+size-1 DOWNTO 0));
END COMPONENT MAC_Unit;

COMPONENT multiplier IS
    generic(N : INTEGER := 4);                             -- Sets the multiplier to 16 bit default
    PORT( a ,b : in STD_LOGIC_VECTOR;       
		  p : out STD_LOGIC_VECTOR); 
END COMPONENT multiplier;

FUNCTION truncate (SIGNAL a, b: STD_LOGIC_VECTOR; size: INTEGER) RETURN STD_LOGIC_VECTOR;

END PACKAGE MAC_Package;
------------------- Package body declarations
PACKAGE BODY MAC_Package IS
--FUNCTION truncate (SIGNAL a, b: STD_LOGIC_VECTOR; size: integer) RETURN STD_LOGIC_VECTOR IS ------ SIGNED DECIMALS
--VARIABLE result: STD_LOGIC_VECTOR(size+size-1 downto 0);
--    BEGIN   
--        result := a + b;
--        if(a(a'high) = b(b'high)) then
--            if(result(result'high) /= a(a'high)) then
--                if(a(a'high) = '0') then
--                    result := (result'high => '0', others => '1');
--                else
--                    result := (result'high => '1', others => '0');
--                end if;
--            end if;
--        end if;       
--    return result;
--END function truncate;

FUNCTION truncate (SIGNAL a, b: STD_LOGIC_VECTOR; size: integer) RETURN STD_LOGIC_VECTOR IS --- UNSIGNED DECIMALS
VARIABLE result: STD_LOGIC_VECTOR(size+size-1 downto 0);
    BEGIN   
        result := a + b;
                If(a(a'high) = '1' OR b(b'high) = '1') THEN
                    IF(result(result'high) /= '1') THEN
                        result := (result'high => '1', others => '1');
                    END IF;
                END IF;              
    return result;
END function truncate;


end package body MAC_Package;