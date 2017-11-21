library IEEE;
use IEEE.Std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;

entity lab1_tb is
end;

architecture bench of lab1_tb is

  component lab1
      Port ( clk : in STD_LOGIC;
             d : in STD_LOGIC_VECTOR (3 downto 0);
             sel : in STD_LOGIC_VECTOR (1 downto 0);
             q : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal clk : std_logic;
  signal d: STD_LOGIC_VECTOR (3 downto 0);
  signal sel: STD_LOGIC_VECTOR (1 downto 0);
  signal q: STD_LOGIC_VECTOR (3 downto 0);
  signal q1, q2, q3, q4: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 20 ns;
  signal stop_the_clock: boolean;

begin

  stimulus: process
  begin
 
  
    -- Put initialisation code here
    
    d <= "0001";    
    sel <= "00";
    wait until (clk'EVENT AND clk='1');
    d <= "0101";    
    sel <= "00";
    wait until (clk'EVENT AND clk='1');
    d <= "0011";    
    sel <= "00";
    wait until (clk'EVENT AND clk='1');        
    d <= "1001";    
    sel <= "01";
    wait until (clk'EVENT AND clk='1');
    d <= "0100";    
    sel <= "01";
    wait until (clk'EVENT AND clk='1');
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

alu1: lab1 port map (clk, d, sel, q);
end;