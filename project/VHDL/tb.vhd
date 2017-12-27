library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.NODE_Package.all;
use work.adder_package.all;

entity node_tb is
end;

architecture bench of node_tb is

  constant clock_period: time := 20 ns; -- sets the clock period to 20 ns
  signal stop_the_clock: boolean;
 

  component NODE
      PORT (x: IN INPUTARRAY;
        weight: IN SIGNED;
        clk, rst: IN STD_LOGIC;
        y: OUT SIGNED(M-1 DOWNTO 0));
  end component;

  signal xIn: INPUTARRAY;
  signal weightIN: SIGNED(N-1 DOWNTO 0);
  signal y: SIGNED(M-1 DOWNTO 0);
  
  SIGNAL clk: STD_LOGIC;
  SIGNAL rst: STD_LOGIC;

begin

  nod : NODE port map (x => xIn,
                         weight => weightIN,
                         clk => clk,
                         rst => rst,
                         y => y);

  stimulus: process
  begin
  rst <= '0';
  weightIN <= "0010";
  xIN(0) <= "1000";
  xIN(1) <= "0001";
  xIN(2) <= "0001";
  xIN(3) <= "0001";

  wait for 10 ns;

  weightIN <= "0010";
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  
  wait until (clk'EVENT AND clk='1');
  weightIN <= "0001";
  
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