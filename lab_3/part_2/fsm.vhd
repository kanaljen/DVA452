library ieee;
use ieee.std_logic_1164.all;

entity fsm is

	port(clk : in std_logic;
		 out1, out2 : out std_logic);
end fsm;

architecture process_model of fsm is
	
	type state is (S0,S1,S2,S3);
	signal pstate : state := S0; 
	signal nstate : state; 

	begin -- process_model arch

	statesetter :process(clk)
		
		begin

		if rising_edge(clk) then
			pstate <= nstate; -- set new present state
		end if;

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

end architecture ; -- process_model arch