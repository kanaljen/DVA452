library IEEE;
use IEEE.Std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.Numeric_Std.all;

entity lab1_tb is
end;

architecture bench of lab1_tb is

  component shiftReg
      Port ( clk : in STD_LOGIC;
             d : in STD_LOGIC_VECTOR (3 downto 0);
             sel : in STD_LOGIC_VECTOR (1 downto 0);
             q : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  signal clk : std_logic;
  signal d: STD_LOGIC_VECTOR (3 downto 0);
  signal sel: STD_LOGIC_VECTOR (1 downto 0);
  signal q: STD_LOGIC_VECTOR (3 downto 0);

  constant clock_period: time := 20 ns; -- sets the clock period to 20 ns
  signal stop_the_clock: boolean;

begin

  -- d input is counting from 0 to 7 in binary while select increase from 0 to 3 to read outputs from the flipflops in sequence
  counter: process
  begin
    
    d <= "0000"; -- Initialize input value
    sel <= "00"; -- Initialize MUX select
    wait until (clk'EVENT AND clk='1');
    d <= "0001";
    sel <= "00";
    wait until (clk'EVENT AND clk='1');
    d <= "0010";    
    sel <= "01";
    wait until (clk'EVENT AND clk='1');
    d <= "0011";    
    sel <= "10";
    wait until (clk'EVENT AND clk='1');        
    d <= "0100";    
    sel <= "11";
    wait until (clk'EVENT AND clk='1');
    d <= "0101";    
    sel <= "10";
    wait until (clk'EVENT AND clk='1');
    d <= "0110";    
    sel <= "01";
    wait until (clk'EVENT AND clk='1');
    d <= "0111";    
    sel <= "00";
    wait until (clk'EVENT AND clk='1');

    stop_the_clock <= true; -- stops the clock when the test is complete
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop -- loops the clock while the test is running
      clk <= '0', '1' after clock_period / 2; -- assign 0 to the clock for half the period, then 1
      wait for clock_period; -- wait for a whole period
    end loop;
    wait;
  end process;

shiftRegister: shiftReg port map (clk, d, sel, q);

end;