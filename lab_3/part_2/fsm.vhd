library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           out1 : out STD_LOGIC;
           out2 : out STD_LOGIC);
end fsm;

architecture Behavioral of fsm is
TYPE state is (state0, state1, state2, state3, state4, state5, state6, state7); 
Signal pr_state, nx_state: state; 
begin
PROCESS (rst,clk)
Begin
    IF(rst='1') THEN	-- reset signal, restart at state zero.
        pr_state <= state0;
    ELSIF(clk'EVENT AND clk='1') THEN -- switches state when clock is on its rising edge.
        pr_state <= nx_state;    
    ELSIF(clk'EVENT AND clk='0')THEN -- switches state when clock is on its falling edge.
        pr_state <= nx_state; 
    END IF;
END PROCESS;

PROCESS (pr_state) -- activated when the state changes
Begin
    CASE pr_state IS				-- Entering present state
        WHEN state0 =>
            out1 <= '1';			-- Setting the desired output
            out2 <= '1';			-- Setting the desired output
            nx_state <= state1;     -- Setting next state to state2   
        WHEN state1 =>
            out1 <= '1';
            out2 <= '1';
            nx_state <= state2;
        WHEN state2 =>
            out1 <= '0';
            out2 <= '0';
            nx_state <= state3;  
        WHEN state3 =>
            out1 <= '0';
            out2 <= '1';
            nx_state <= state4;
        WHEN state4 =>
            out1 <= '0';
            out2 <= '0';
            nx_state <= state5;        
        WHEN state5 =>
            out1 <= '0';
            out2 <= '0';
            nx_state <= state6;
        WHEN state6 =>
            out1 <= '0';
            out2 <= '0';
            nx_state <= state7;  
        WHEN state7 =>
            out1 <= '0';
            out2 <= '0';
            nx_state <= state0;
    END CASE;    
END PROCESS;
end Behavioral;
