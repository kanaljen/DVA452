LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.adder_Package.all;

PACKAGE FIRST_NODE_PACKAGE IS

COMPONENT FIRST_NODE
      PORT (x: IN FIRSTINPUTARRAY;
            weightIn: IN SIGNED(M-1 DOWNTO 0);
            weightOut: OUT SIGNED(M-1 DOWNTO 0);
            clk, rst: IN STD_LOGIC;
            y: OUT SIGNED(M-1 DOWNTO 0));
end component;

end package;

-----------------------------------
----------NODE---------------------
-----------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.FIRST_NODE_Package.all;
use work.MAC_Package.all;
use work.adder_package.all;
use work.LUT_package.all;


entity FIRST_NODE is
    PORT (x: IN FIRSTINPUTARRAY;
            weightIn: IN SIGNED(M-1 DOWNTO 0);
            weightOut: OUT SIGNED(M-1 DOWNTO 0);
          clk, rst: IN STD_LOGIC;
          y: OUT SIGNED(M-1 DOWNTO 0));
end FIRST_NODE;

architecture NN of FIRST_NODE is

    type matrixWeight is array (0 to p_size-1) of SIGNED(M-1 DOWNTO 0); 
    signal weightsIN : matrixWeight;   -- Holds the weight inputs for each MAC
    signal weightsOut : matrixWeight;     -- Holds the weight outputs for each MAC
    
    type matrix is array (0 to p_size-1) of SIGNED(M+M-1 DOWNTO 0); 
    signal sum : matrix;        -- Holds the sum outputs for each MAC
    signal acc : matrix;        -- Holds the acc input for each MAC
    
    SIGNAL node_out : SIGNED(M-1 DOWNTO 0);
    SIGNAL mac_to_lut : SIGNED(M+M-1 DOWNTO 0);

begin
    
    -- Generates each MAC in the Node
    mac_loop : for i in 0 to p_size-1 generate
        MU : MAC_Unit port map( xIn => x(i), 
                                weightIN => weightsIN(i), 
                                acc => acc(i),
                                clk => clk, 
                                rst => rst,
                                weightOUT => weightsOUT(i),
                                sum => sum(i));
    end generate;

        MU : LUT port map( x => mac_to_lut,
                           y => node_out);

    
    weightsIN(0) <= weightIn;                -- Sets the first MACs weight input to the node's weight input.
    acc(0) <= (others => '0');  -- Sets the first MACs acc input to zeros 
    y <= node_out;
    mac_to_lut <= sum(p_size-1);
    weightOut <= weightsOut(p_size-1);
    
    -- Generates all the connections between each MAC
    q_loop : for i in 1 to p_size-1 generate
        weightsIN(i) <= weightsOUT(i-1);
        acc(i) <= sum(i-1);
    end generate;
    
end NN;