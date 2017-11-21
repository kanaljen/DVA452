library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab1 is
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end lab1;

architecture Behavioral of lab1 is

SIGNAL q1, q2, q3, q4: STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

--register--
PROCESS (clk)
BEGIN
    IF (clk'EVENT AND clk='1') THEN
        q1 <= d; -- generates a register
        q2 <= q1;
        q3 <= q2;
        q4 <= q3;
    END IF;
END PROCESS;

--Mux--
WITH sel(1 DOWNTO 0) SELECT
   q <=   q1 WHEN "00",
          q2 WHEN "01",
          q3 WHEN "10",
          q4 WHEN OTHERS;


end Behavioral;