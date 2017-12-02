library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity main_part2_tb is
GENERIC (size : INTEGER := 4);
end;

architecture bench of main_part2_tb is

  constant clock_period: time := 20 ns; -- sets the clock period to 20 ns
  signal stop_the_clock: boolean;

  component MAC_Unit
      PORT( a, b: IN STD_LOGIC_VECTOR (size-1 DOWNTO 0);
          clk, rst: IN STD_LOGIC;
          acc: OUT STD_LOGIC_VECTOR (size+size-1 DOWNTO 0));
  end component;

  signal a, b: STD_LOGIC_VECTOR (size-1 DOWNTO 0);
  signal acc: STD_LOGIC_VECTOR (size+size-1 DOWNTO 0);
  SIGNAL clk: STD_LOGIC;
  SIGNAL rst: STD_LOGIC;

begin

  uut: MAC_Unit port map ( a   => a,
                             b   => b,
                             clk => clk,
                             rst => rst,                             
                             acc => acc );

  stimulus: process
  begin
  rst <= '0';
  a <= "1000";
  b <= "0101";
    ---- testcase 1
  wait until (clk'EVENT AND clk='1');
  a <= "1100";
  b <= "1101";
  rst <='0';
  ---- testcase 2
  wait until (clk'EVENT AND clk='1');
  a <= "0101";
  b <= "1010";
  rst <='0';
  ---- testcase 3
  wait until (clk'EVENT AND clk='1');
  a <= "0100";
  b <= "0111";
   
    ---- testcase 2
  wait until (clk'EVENT AND clk='1');
  a <= "0101";
  b <= "0010";
  rst <='0';
  wait until (clk'EVENT AND clk='1');
  a <= "0101";
  b <= "1010";
  rst <='1';
  wait until (clk'EVENT AND clk='1');
  a <= "0100";
  b <= "0011";
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