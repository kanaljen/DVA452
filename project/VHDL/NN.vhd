library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.NODE_Package.all;
use work.MAC_Package.all;
--use work.NET_Package.all;
use work.ONE_LAYER_PACKAGE.all;
use work.FIRST_LAYER_PACKAGE.all;
use work.ADDER_PACKAGE.ALL;
use work.OUTPUT_NODE_PACKAGE.ALL;

entity MLP_NN is
      PORT (x: IN FIRSTINPUTARRAY;
      clk, rst: IN STD_LOGIC;
      weight: IN WEIGHTINPUTMATRIX;
      y: OUT INTEGER);
end MLP_NN;

architecture NN of MLP_NN is

    signal sum : INPUTMATRIX;        -- Holds the sum outputs for each Layer
    signal pixel_inputs : FIRSTINPUTARRAY;        -- Holds the acc input for each Layer
    signal acc : INPUTMATRIX;        -- Holds the acc input for each Layer
    signal output_value : INTEGER;

begin

    input_layer : FIRST_LAYER port map(
                                x => pixel_inputs,
                                weight => weight(0),
                                clk => clk,
                                rst => rst,
                                y => sum(0));
    
    node_loop : for i in 1 to L-1 generate
        node_unit : ONE_LAYER port map(
                                x => acc(i),
                                weight => weight(i),
                                clk => clk,
                                rst => rst,
                                y => sum(i));
    end generate;
    
        output_unit : OUTPUT_NODE port map(
                                x => sum(L-1),
                                clk => clk,
                                rst => rst,
                                y => output_value);
    
   y <= output_value;
   pixel_inputs <= x;

    q_loop : for i in 1 to L-1 generate
             acc(i) <= sum(i-1);
    end generate;
    
end NN;