----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2017 03:11:37 PM
-- Design Name: 
-- Module Name: main_part2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use work.my_package_lab2.all;

entity main_part2 is
    GENERIC (size : INTEGER := 7);
    PORT( a, b: IN SIGNED (size DOWNTO 0);
        clk, rst: IN STD_LOGIC;
        acc: OUT SIGNED (size DOWNTO 0));
end main_part2;

architecture Behavioral of main_part2 is
    SIGNAL prod: SIGNED (size DOWNTO 0) := (OTHERS => '0');
    SIGNAL sum: SIGNED (size DOWNTO 0) := (OTHERS => '0');
begin
    prod <= truncate(a, b, size);
    acc <= sum;
--U1 : MAC_UNIT PORT MAP(a => a, b => b, sum => sum);

PROCESS (clk, rst)
BEGIN
    IF (rst = '1') THEN
        sum <= (others => '0');
    ELSIF (clk'EVENT AND CLK = '1') THEN
        sum <= truncate(prod,sum, size);
    END IF;
END PROCESS;

END Behavioral;
