library ieee;
use ieee.std_logic_1164.all;

entity fsm is
	generic(cycle : time := 10 ns);
	port(out1, out2 : out std_logic);
end fsm;

architecture process_model of fsm is
	
	type state is (S2,S1,S0);
	signal pstate : state := S0; 
	signal nstate : state;
	signal clk : std_logic := '0';

	begin -- process_model arch

	synced_process :process(clk)
		
		begin
		
			if (pstate = S0) then

				pstate <= S1;
				out1 <= '1';
				out2 <= '0';

			elsif (pstate = S1) then

				pstate <= S0;
				out1 <= '0';
				out2 <= '1';
				
			end if ;

	end process; -- synced_process

	-- clock running at a generic time cycle
	clk <= not clk after cycle/2; 

end architecture ; -- process_model arch