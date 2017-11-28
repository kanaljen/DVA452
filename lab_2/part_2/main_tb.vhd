library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity main_part2_tb is
GENERIC (size : INTEGER := 7);
end;

architecture bench of main_part2_tb is

  constant clock_period: time := 20 ns; -- sets the clock period to 20 ns
  signal stop_the_clock: boolean;

  component main_part2
      PORT( a, b: IN SIGNED (size DOWNTO 0);
          clk, rst: IN STD_LOGIC;
          acc: OUT SIGNED (size DOWNTO 0));
  end component;

  signal a, b: SIGNED (size DOWNTO 0);
  signal acc: SIGNED (size DOWNTO 0);
  SIGNAL clk: STD_LOGIC;
  SIGNAL rst: STD_LOGIC;

begin

  uut: main_part2 port map ( a   => a,
                             b   => b,
                             clk => clk,
                             rst => rst,                             
                             acc => acc );

  stimulus: process
  begin
  rst <= '0';
  a <= "00000100";
  b <= "00000101";
    ---- testcase 1
  wait until (clk'EVENT AND clk='1');
  a <= "00000100";
  b <= "00000101";
  rst <='0';
  ---- testcase 2
  wait until (clk'EVENT AND clk='1');
  a <= "00000101";
  b <= "00000010";
  rst <='0';
  ---- testcase 3
  wait until (clk'EVENT AND clk='1');
  a <= "10000100";
  b <= "10000111";
   
    ---- testcase 2
  wait until (clk'EVENT AND clk='1');
  a <= "01000101";
  b <= "01000010";
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