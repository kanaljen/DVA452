library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fsm_tb is
end;

architecture bench of fsm_tb is

  component fsm
      Port ( clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             out1 : out STD_LOGIC;
             out2 : out STD_LOGIC);
  end component;

  signal clk: STD_LOGIC:='1';
  signal rst: STD_LOGIC;
  signal out1: STD_LOGIC;
  signal out2: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: fsm 
              port map ( clk  => clk,
                         rst  => rst,
                         out1 => out1,
                         out2 => out2 );

  stimulus: process
  begin
  
    -- This test bench code will go through all stages two times
    
    wait until (clk'EVENT AND clk = '1');
    
    wait until (clk'EVENT AND clk = '1');
   
    wait until (clk'EVENT AND clk = '1');
    
    wait until (clk'EVENT AND clk = '1');
    
    wait until (clk'EVENT AND clk = '1');
    
    wait until (clk'EVENT AND clk = '1');
    
    wait until (clk'EVENT AND clk = '1');
    
    wait until (clk'EVENT AND clk = '1');

    wait until (clk'EVENT AND clk = '1');
    
    -- test bench stimulus code 

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '1', '0' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;