library ieee;
use ieee.std_logic_1164.all;

entity fsm_tb is
end fsm_tb;

architecture testbech of fsm_tb is

	component fsm

		port(clk : in std_logic;
		 	 out1, out2 : out std_logic);

	end component;

	signal clk : std_logic := '1';
	signal out1, out2 : std_logic;

	constant clock_period : time := 10 ns;

begin
	
	statemachine: fsm port map(
		clk => clk,
		out1 => out1,
		out2 => out2);

	clk <= not clk after clock_period/2; 

end architecture ; -- arch

