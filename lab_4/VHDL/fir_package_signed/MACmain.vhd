library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.adder_package.all;
use work.MAC_Package.all;

entity MAC_Unit is
    GENERIC (size : INTEGER := c_size);
    PORT( xIn, coef, acc: IN STD_LOGIC_VECTOR (size-1 DOWNTO 0);
          clk, rst: IN STD_LOGIC;
          q: OUT STD_LOGIC_VECTOR (size-1 DOWNTO 0);
          sum: OUT STD_LOGIC_VECTOR (size+size-1 DOWNTO 0));
end MAC_Unit;

architecture Behavioral of MAC_Unit is
    SIGNAL prod: STD_LOGIC_VECTOR (size+size-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL prodSum: STD_LOGIC_VECTOR (size+size-1 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL prodA : STD_LOGIC_VECTOR (size-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL prodB : STD_LOGIC_VECTOR (size-1 DOWNTO 0) := (OTHERS => '0');
begin

    muli : multiplier port map (a => xIn,
                                b => coef,
                                p => prod);
    
    sum <= prodSum;

PROCESS (clk, rst)

-- variable negativeProd : bit := '0';

BEGIN
-- För negativa tal
-- TODO
-- lägga på 1 på prod talet
-- bestämma om negativt efter mult
--    IF (a(a'high) = '1') THEN
--        for i in 0 to a'high loop
--            if(a(i) = '1') then
--                prodA(i) <= '0';
--            else
--                prodA(i) <= '1';
--            end if;
--        end loop;
--        if( negativeProd = '0') then
--            negativeProd := '1';
--        end if;
--    END IF;
--    IF(b(b'high) = '1') THEN
--        for i in 0 to b'high loop
--            if(b(i) = '1') then
--                prodB(i) <= '0';
--            else
--                prodB(i) <= '1';
--            end if;
--            prodB <= prodB + 1;
--        end loop;
--        if( negativeProd = '0') then
--            negativeProd := '1';
--        elsif
--            negativeProd
--        end if;
--    END IF;
        
    IF (rst = '1') THEN
        prodSum <= (others => '0');
    ELSIF (clk'EVENT AND CLK = '1') THEN
        q <= xIn;
    END IF;
    
    prodSum <= truncate(prod,acc, size+size-1);
END PROCESS;

END Behavioral;