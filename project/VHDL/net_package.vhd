LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.NODE_Package.all;
use work.ONE_LAYER_PACKAGE.ALL;
use work.ADDER_PACKAGE.ALL;

PACKAGE NET_PACKAGE IS

COMPONENT NET
      PORT (x: IN INPUTARRAY;
            clk, rst: IN STD_LOGIC;
            weight: IN WEIGHTINPUTMATRIX;
            y: OUT SIGNED(M-1 DOWNTO 0));
end component;

end package;

-----------------------------------
----------NODE---------------------
-----------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.NODE_Package.all;
use work.MAC_Package.all;
use work.NET_Package.all;
use work.ONE_LAYER_PACKAGE.all;
use work.ADDER_PACKAGE.ALL;
use work.OUTPUT_NODE_PACKAGE.ALL;

entity NET is
      PORT (x: IN INPUTARRAY;
      clk, rst: IN STD_LOGIC;
      weight: IN WEIGHTINPUTMATRIX;
      y: OUT SIGNED(M-1 DOWNTO 0));
end NET;

architecture NN of NET is

    signal sum : INPUTMATRIX;        -- Holds the sum outputs for each Layer
    signal acc : INPUTMATRIX;        -- Holds the acc input for each Layer
    signal output_value : SIGNED(M-1 DOWNTO 0);

begin
    
    node_loop : for i in 0 to L-1 generate
        node_unit : ONE_LAYER port map(
                                x => acc(i),
                                weight => weight(i),
                                clk => clk,
                                rst => rst,
                                y => sum(i));
    end generate;
    
    output_node_loop : for j in 0 to 0 generate
        output_unit : OUTPUT_NODE port map(
                                x => sum(L-1),
                                clk => clk,
                                rst => rst,
                                y => output_value);
    end generate;
    
    y <= output_value;

    q_loop : for i in 1 to L-1 generate
             acc(i) <= sum(i-1);
    end generate;
    
end NN;