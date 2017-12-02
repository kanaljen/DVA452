library ieee;
use ieee.std_logic_1164.all;

entity fsm is
	generic(cycle : time := 10 ns);
	port(out1, out2 : out std_logic);
end fsm;

architecture process_model of fsm is
	
	type state is (S0,S1,S2,S3);
	signal pstate : state := S3; 
	signal nstate : state := S0; 
	signal clk : std_logic := '1';

	begin -- process_model arch

	statesetter :process(clk)
		
		begin

		pstate <= nstate; -- set new present state

			case pstate is -- set next state
   				when S0 => nstate <= S1;
   				when S1 => nstate <= S2;
   				when S2 => nstate <= S3;
   				when S3 => nstate <= S0;
   				when others => report "state failure" severity failure;
			end case;

	end process; -- statesetter

	-- set out-signals
	with pstate select
		out1 <= '1' when S0,
				'0' when others;

	out2 <= '1' when (pstate = S0) else
			'0' when (pstate = S1 AND clk = '1') else
			'1'	when (pstate = S1 AND clk = '0') else '0';

	-- clock running at a generic time cycle
	clk <= not clk after cycle/2; 

end architecture ; -- process_model arch