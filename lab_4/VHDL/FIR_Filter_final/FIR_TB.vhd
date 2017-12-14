library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.FIR_Package.all;

entity fir_tb is
end;

architecture bench of fir_tb is

  constant clock_period: time := 20 ns; -- sets the clock period to 20 ns
  signal stop_the_clock: boolean;
 

  component FIR
      PORT (x: in SIGNED (M-1 DOWNTO 0);
            coef: in coefficient;
            clk, rst: in STD_LOGIC;
            y: out SIGNED(M+M-1 DOWNTO 0));
  end component;

  signal xIn: SIGNED (N-1 DOWNTO 0);
  signal coef: coefficient;
  signal y: SIGNED (N+N-1 DOWNTO 0);
  
  SIGNAL clk: STD_LOGIC;
  SIGNAL rst: STD_LOGIC;

begin

  filter : FIR port map (x => xIn,
                         coef => coef,
                         clk => clk,
                         rst => rst,
                         y => y);

  stimulus: process
  begin
  rst <= '0';
  xIn <= "1101";
  coef(0) <= "0010";
  coef(1) <= "1111";
  coef(2) <= "1111";
  coef(3) <= "1110";

  wait for 10 ns;

  xIn <= "0101";
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');

  stop_the_clock <= true;
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

end;