LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.NODE_Package.all;
use work.ONE_LAYER_PACKAGE.ALL;
use work.ADDER_PACKAGE.ALL;

PACKAGE NET_PACKAGE IS

--CONSTANT K : INTEGER := 2; -- k= # of layers.,
--CONSTANT L : INTEGER := 2; -- k= # of Nodes / Layer.,
--CONSTANT N : INTEGER := 4; -- n= # of coef.,
--CONSTANT M : INTEGER := 4; -- m= # of bits of input and coef.
--TYPE INPUTMATRIX IS ARRAY (K-1 DOWNTO 0) OF INPUTARRAY;
--TYPE INPUTMATRIXARRAY IS ARRAY (L-1 DOWNTO 0) OF INPUTMATRIX;

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

    signal weightIN : INPUTARRAY;   -- Holds the x inputs for each MAC
    signal weightOut : INPUTARRAY;     -- Holds the q outputs for each MAC
    
    type matrix is array (0 to N-1) of INPUTMATRIX; 
    signal sum : INPUTMATRIX;        -- Holds the sum outputs for each MAC
    signal acc : INPUTMATRIX;        -- Holds the acc input for each MAC
    signal output_value : SIGNED(M-1 DOWNTO 0);

begin
    
    -- Generates each Node in the Layer
    node_loop : for i in 0 to L-1 generate
    --node_loop : for j in 0 to L-1 generate
        node_unit : ONE_LAYER port map(
                                x => acc(i),
                                weight => weight(i),
                                clk => clk,
                                rst => rst,
                                y => sum(i));
   -- end generate;
    end generate;
    
        output_node_loop : for j in 0 to 0 generate
    --node_loop : for j in 0 to L-1 generate
        output_unit : OUTPUT_NODE port map(
                                x => sum(L-1),
                                clk => clk,
                                rst => rst,
                                y => output_value);
   -- end generate;
    end generate;
    
    y <= output_value;
   -- weightIN(0) <= weight;                -- Sets the first MACs x input to the FIR x input.
   
   -- acc(0)(0)(0) <= (others => '0');  -- Sets the first MACs acc input to zeros 
                                -- as the first addition should not change the first product
    --y <= sum(N);
    
    -- Generates all the connections between each Layer
    q_loop : for i in 1 to L-1 generate
             acc(i) <= sum(i-1);
    end generate;
    
    -- Flip-Flops the last sum of the MACs to the y output
    PROCESS(clk) 
    BEGIN
        IF (clk'EVENT AND CLK = '1') THEN
           -- y <= sum(N-1);
        END IF;
    END PROCESS;
end NN;