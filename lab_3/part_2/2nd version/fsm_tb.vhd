library ieee;
use ieee.std_logic_1164.all;

entity fsm_tb is
end fsm_tb;

architecture testbech of fsm_tb is

	component fsm

		port(clk : in std_logic;
		 	 out1, out2 : out std_logic);

	end component;

	signal clk : std_logic;
	signal out1, out2 : std_logic;

	constant clock_period : time := 10 ns;

begin
	
	statemachine: fsm port map(
		clk => clk,
		out1 => out1,
		out2 => out2);

	stim: process
		begin
		
		for i in 0 to 7 loop

			if clk = '1' then
				clk <= '0';
			else
				clk <= '1';
			end if;

			wait for clock_period/2;

		end loop;

		wait;

	end process;

end architecture ; -- arch

