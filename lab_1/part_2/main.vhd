library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;

entity shiftReg is
    Port ( clk : in STD_LOGIC; --Clock
           d : in STD_LOGIC_VECTOR (3 downto 0); --Input
           sel : in STD_LOGIC_VECTOR (1 downto 0); --MUX Select
           q : out STD_LOGIC_VECTOR (3 downto 0)); --MUX Output
end shiftReg;

architecture Behavioral of shiftReg is

SIGNAL q1, q2, q3, q4: STD_LOGIC_VECTOR (3 DOWNTO 0); --FlipFlop Outputs

begin

--register--
PROCESS (clk)
BEGIN
    IF (clk'EVENT AND clk='1') THEN -- when clock is rising
        q1 <= d; -- generates a register, sets new output to each flipflop
        q2 <= q1;
        q3 <= q2;
        q4 <= q3;
    END IF;
END PROCESS;

--Mux--
WITH sel(1 DOWNTO 0) SELECT -- selects from 2 bit input which flipflop output to set as MUX output. Does not rely on the clock
   q <=   q1 WHEN "00",
          q2 WHEN "01",
          q3 WHEN "10",
          q4 WHEN OTHERS;

end Behavioral;