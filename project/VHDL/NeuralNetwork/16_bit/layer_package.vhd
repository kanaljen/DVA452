LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.NODE_Package.all;
use work.adder_Package.all;

PACKAGE ONE_LAYER_PACKAGE IS

COMPONENT ONE_LAYER
      PORT (x: IN INPUTARRAY;
            clk, rst: IN STD_LOGIC;
            weightIn: IN SIGNED(M-1 DOWNTO 0);
            weightOut: OUT SIGNED(M-1 DOWNTO 0);
            y: OUT INPUTARRAY);
end component;

end package;

-----------------------------------
----------Layer---------------------
-----------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.NODE_Package.all;
use work.MAC_Package.all;
use work.ONE_LAYER_Package.all;
use work.adder_Package.all;

entity ONE_LAYER is
      PORT (x: IN INPUTARRAY;
      clk, rst: IN STD_LOGIC;
      weightIn: IN SIGNED(M-1 DOWNTO 0);
      weightOut: OUT SIGNED(M-1 DOWNTO 0);
      y: OUT INPUTARRAY);
end ONE_LAYER;

architecture NN of ONE_LAYER is
    
    signal sum : INPUTARRAY;        -- Holds the sum outputs for each Node
    signal acc : INPUTARRAY;        -- Holds the acc input for each Node
    Signal weightsOut : WEIGHTINPUTARRAY;
    Signal weightsIn : WEIGHTINPUTARRAY;

begin
    
    -- Generates each Node in the Layer
    node_loop : for i in 0 to K-1 generate
        node_unit : NODE port map(
                                x => acc,
                                weightIn => weightsIn(i),
                                weightOut => weightsOut(i),
                                clk => clk,
                                rst => rst,
                                y => sum(i));
    end generate;
    
        q_loop : for i in 1 to K-1 generate
        weightsIN(i) <= weightsOUT(i-1);
    end generate;
    
    weightsIn(0) <= weightIn;
    weightOut <= weightsOut(K-1);
    y <= sum;
    acc <= x;
    
end NN;