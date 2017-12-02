library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use work.MAC_Package.all;

entity MAC_Unit is
    GENERIC (size : INTEGER := 4);
    PORT( a, b: IN STD_LOGIC_VECTOR (size-1 DOWNTO 0);
        clk, rst: IN STD_LOGIC;
        acc: OUT STD_LOGIC_VECTOR (size+size-1 DOWNTO 0));
end MAC_Unit;

architecture Behavioral of MAC_Unit is
    SIGNAL prod: STD_LOGIC_VECTOR (size+size-1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sum: STD_LOGIC_VECTOR (size+size-1 DOWNTO 0) := (OTHERS => '0');
begin

    muli : multiplier port map (a => a,
                                b => b,
                                p => prod);
    acc <= sum;

PROCESS (clk, rst)
BEGIN
    IF (rst = '1') THEN
        sum <= (others => '0');
    ELSIF (clk'EVENT AND CLK = '1') THEN
        sum <= truncate(prod,sum, size);
    END IF;
END PROCESS;

END Behavioral;
