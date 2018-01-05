library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.NODE_Package.all;
use work.adder_package.all;
--use work.net_package.all;

entity net_tb is
end;

architecture bench of net_tb is

  constant clock_period: time := 20 ns; -- sets the clock period to 20 ns
  signal stop_the_clock: boolean;
 

  component MLP_NN
      PORT (x: IN FIRSTINPUTARRAY;
  clk, rst, ena_weights: IN STD_LOGIC;
  weight: IN SIGNED(M-1 DOWNTO 0);
  y: OUT INPUTARRAY);
  end component;

  signal xIn: FIRSTINPUTARRAY;
  signal weightsIN: SIGNED(M-1 DOWNTO 0);
  signal y: INPUTARRAY;
  
  signal ena: STD_LOGIC;
  SIGNAL clk: STD_LOGIC;
  SIGNAL rst: STD_LOGIC;

begin

  net_net : MLP_NN port map (x => xIn,
                         weight => weightsIN,
                         clk => clk,
                         rst => rst,
                         ena_weights => ena,
                         y => y);

  stimulus: process
  begin
  rst <= '0';
  ena <= '1';
    --weightIN(0) <= "0010";
    --weightIN(1) <= "0010";
    --weightIN(2) <= "0010";
    --weightIN(3) <= "0010";   
--  weightIN(0)(0) <= "0010";
--  weightIN(0)(1) <= "0001";
----  weightIN(0)(2) <= "0001";
----  weightIN(0)(3) <= "0010";
--  weightIN(1)(0) <= "0010";
--  weightIN(1)(1) <= "0001";
--  xIN(0) <= "0010";
--  xIN(1) <= "0001";
--  xIN(2) <= "0010";
--  xIN(3) <= "0001";
  --xIN(2) <= "0001";
  --xIN(3) <= "0001";
--  weightIN(0)(0) <= "00000001";
--  weightIN(0)(1) <= "00000001";
--  weightIN(1)(0) <= "00000001";
--  weightIN(1)(1) <= "00000001";
--  weightIN(0)(2) <= "00000001";
--  weightIN(0)(3) <= "00000001";
--  weightIN(1)(2) <= "00000001";
--  weightIN(1)(3) <= "00000100";
 -- weightsIn <= "00000010";
--  xIN(0) <= "00000001";
--  xIN(1) <= "00000001";
--  xIN(2) <= "00000001";
--  xIN(3) <= "00000001";

 -- wait for 10 ns;
        
--  for i in 0 to K-1 loop
--      for j in 0 to N-1 loop
--          xIn(0)(i)(j) <= "0001";
--      end loop;
--  end loop;
  


  for i in 0 to (K * p_size) loop
  wait until (clk'EVENT AND clk='1');
  end loop;
--  --weightsIn <= "00000001";
--  wait until (clk'EVENT AND clk='1');
-- -- weightsIn <= "00000001";
--  wait until (clk'EVENT AND clk='1');
--  -- weightIN(0)(0) <= "0001";
--  wait until (clk'EVENT AND clk='1');
  
--  wait until (clk'EVENT AND clk='1');
  
--  wait until (clk'EVENT AND clk='1');
  
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');
--  wait until (clk'EVENT AND clk='1');

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