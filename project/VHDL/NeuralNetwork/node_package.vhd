LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.adder_Package.all;

PACKAGE NODE_PACKAGE IS

COMPONENT NODE
      PORT (x: IN INPUTARRAY;
            weight: IN SIGNED(M-1 DOWNTO 0);
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
use work.NODE_Package.all;
use work.MAC_Package.all;
use work.adder_package.all;
use work.LUT_package.all;


entity NODE is
    PORT (x: IN INPUTARRAY;
          weight: IN SIGNED(M-1 DOWNTO 0);
          clk, rst: IN STD_LOGIC;
          y: OUT SIGNED(M-1 DOWNTO 0));
end NODE;

architecture NN of NODE is

    type matrixWeight is array (0 to N-1) of SIGNED(M-1 DOWNTO 0); 
    signal weightIN : matrixWeight;   -- Holds the weight inputs for each MAC
    signal weightOut : matrixWeight;     -- Holds the weight outputs for each MAC
    
    type matrix is array (0 to N-1) of SIGNED(M+M-1 DOWNTO 0); 
    signal sum : matrix;        -- Holds the sum outputs for each MAC
    signal acc : matrix;        -- Holds the acc input for each MAC
    
    SIGNAL node_out : SIGNED(M-1 DOWNTO 0);
    SIGNAL mac_to_lut : SIGNED(M+M-1 DOWNTO 0);

begin
    
    -- Generates each MAC in the Node
    mac_loop : for i in 0 to N-1 generate
        MU : MAC_Unit port map( xIn => x(i), 
                                weightIN => weightIN(i), 
                                acc => acc(i),
                                clk => clk, 
                                rst => rst,
                                weightOUT => weightOUT(i),
                                sum => sum(i));
    end generate;

        MU : LUT port map( x => mac_to_lut,
                           y => node_out);

    
    weightIN(0) <= weight;                -- Sets the first MACs weight input to the node's weight input.
    acc(0) <= (others => '0');  -- Sets the first MACs acc input to zeros 
    y <= node_out;
    mac_to_lut <= sum(N-1);
    
    -- Generates all the connections between each MAC
    q_loop : for i in 1 to N-1 generate
        weightIN(i) <= weightOUT(i-1);
        acc(i) <= sum(i-1);
    end generate;
    
end NN;