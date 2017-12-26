LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.NODE_Package.all;
use work.adder_Package.all;

PACKAGE ONE_LAYER_PACKAGE IS

--CONSTANT K : INTEGER := 2; -- k= # of layers.,
--CONSTANT L : INTEGER := 2; -- k= # of Nodes / Layer.,
--CONSTANT N : INTEGER := 4; -- n= # of coef.,
--CONSTANT M : INTEGER := 4; -- m= # of bits of input and coef.

COMPONENT ONE_LAYER
      PORT (x: IN INPUTARRAY;
            clk, rst: IN STD_LOGIC;
            weight: IN WEIGHTINPUTARRAY;
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
      weight: IN WEIGHTINPUTARRAY;
      y: OUT INPUTARRAY);
end ONE_LAYER;

architecture NN of ONE_LAYER is

    signal weightIN : INPUTARRAY;   -- Holds the x inputs for each MAC
    signal weightOut : INPUTARRAY;     -- Holds the q outputs for each MAC
    
    type matrix is array (0 to N-1) of INPUTMATRIX; 
    signal sum : INPUTARRAY;        -- Holds the sum outputs for each MAC
    signal acc : INPUTARRAY;        -- Holds the acc input for each MAC

begin
    
    -- Generates each Node in the Layer
    node_loop : for i in 0 to K-1 generate
   -- node_loop : for j in 0 to L-1 generate
        node_unit : NODE port map(
                                x => acc,
                                weight => weight(i),
                                clk => clk,
                                rst => rst,
                                y => sum(i));
   -- end generate;
    end generate;
    
   -- weightIN(0) <= weight;                -- Sets the first MACs x input to the FIR x input.
   
    --acc(0)(0)(0) <= (others => '0');  -- Sets the first MACs acc input to zeros 
                                -- as the first addition should not change the first product
    --y <= sum(N);
    y <= sum;
    acc <= x;
    
    -- Generates all the connections between each Layer
    q_loop : for i in 1 to K-1 generate
   -- q_loop2 : for j in 0 to L-1 generate
        --acc(i) <= sum;
        --sum(i) <= x(i)(j)
  --  end generate;
    end generate;
    
    -- Flip-Flops the last sum of the MACs to the y output
    PROCESS(clk) 
    BEGIN
        IF (clk'EVENT AND CLK = '1') THEN
           -- y <= sum(N-1);
        END IF;
    END PROCESS;
end NN;