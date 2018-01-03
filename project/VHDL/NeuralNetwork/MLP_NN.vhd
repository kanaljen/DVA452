library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.NODE_Package.all;
use work.MAC_Package.all;
--use work.NET_Package.all;
use work.ONE_LAYER_PACKAGE.all;
use work.FIRST_LAYER_PACKAGE.all;
use work.ADDER_PACKAGE.ALL;
use work.OUTPUT_NODE_PACKAGE.ALL;

entity MLP_NN is
      PORT (x: IN FIRSTINPUTARRAY;
      clk, rst, ena_weights: IN STD_LOGIC;
      weight: IN SIGNED(M-1 DOWNTO 0);
      y: OUT INPUTARRAY);
end MLP_NN;

architecture NN of MLP_NN is

    signal sum : INPUTMATRIX;        -- Holds the sum outputs for each Layer
    signal pixel_inputs : FIRSTINPUTARRAY;        -- Holds the acc input for each Layer
    signal acc : INPUTMATRIX;        -- Holds the acc input for each Layer
    signal output_value : INPUTARRAY;
    signal weightsIn : WEIGHTINPUTMATRIX;
    signal weightsOut : WEIGHTINPUTMATRIX;
    
    SIGNAL addra : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
    SIGNAL douta : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL douta_sgn : SIGNED(7 DOWNTO 0);
    SIGNAL addra_sgn : SIGNED(2 DOWNTO 0);
    SIGNAL addra_max : SIGNED(2 DOWNTO 0) := (others => '1');
    
    COMPONENT blk_mem_gen_0
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
    END COMPONENT;


begin

    input_layer : FIRST_LAYER port map(
                                x => pixel_inputs,
                                weightIn => weightsIn(0),
                                weightOut => weightsOut(0),
                                clk => clk,
                                rst => rst,
                                y => sum(0));
    
    node_loop : for i in 1 to L-1 generate
        node_unit : ONE_LAYER port map(
                                x => acc(i),
                                weightIn => weightsIn(i),
                                weightOut => weightsOut(i),
                                clk => clk,
                                rst => rst,
                                y => sum(i));
    end generate;
    
        output_unit : OUTPUT_NODE port map(
                                x => sum(L-1),
                                clk => clk,
                                rst => rst,
                                y => output_value);
                                
     your_instance_name : blk_mem_gen_0
                                  PORT MAP (
                                    clka => clk,
                                    ena => ena_weights,
                                    addra => addra,
                                    douta => douta
                                  );
   addra_sgn <= signed(addra);
   douta_sgn <= signed(douta);
   weightsIn(0) <= douta_sgn;
   y <= output_value;
   pixel_inputs <= x;

    q_loop : for i in 1 to L-1 generate
             acc(i) <= sum(i-1);
             weightsIN(i) <= weightsOUT(i-1);
    end generate;
    
    PROCESS (clk)
    BEGIN
    IF (CLK'EVENT AND CLK = '1') THEN
            addra <= addra + 1;
    END IF;
    END PROCESS;
    
end NN;