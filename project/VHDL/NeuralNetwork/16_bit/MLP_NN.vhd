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
    
    SIGNAL addra_weights : STD_LOGIC_VECTOR(12 DOWNTO 0) := (others => '0');
    SIGNAL douta_weights : STD_LOGIC_VECTOR(M-1 DOWNTO 0);
    SIGNAL douta_sgn : SIGNED(M-1 DOWNTO 0);
    --SIGNAL addra_sgn : SIGNED(3 DOWNTO 0);                    -- KAN TAS BORT
    --SIGNAL addra_max : SIGNED(3 DOWNTO 0) := (others => '1'); -- KAN TAS BORT
    
    SIGNAL addra_inputs : STD_LOGIC_VECTOR(8 DOWNTO 0) := (others => '0');
    SIGNAL douta_inputs : STD_LOGIC_VECTOR(M-1 DOWNTO 0);
    SIGNAL douta_inputs_sgn : SIGNED(M-1 DOWNTO 0);
    SIGNAL addra_inputs_sgn : SIGNED(8 DOWNTO 0) := (others => '0');
    SIGNAL ena_inputs : STD_LOGIC := '1';
    SIGNAL input_counter : INTEGER;
    
    COMPONENT blk_mem_gen_0
        PORT (
            clka : IN STD_LOGIC;
            ena : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT blk_mem_gen_1
        PORT (
            clka : IN STD_LOGIC;
            ena : IN STD_LOGIC;
            addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
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
                                
    weight_memory : blk_mem_gen_0 PORT MAP (
                                clka => clk,
                                ena => ena_weights,
                                addra => addra_weights,
                                douta => douta_weights
                                );
                                  
    input_memory : blk_mem_gen_1 PORT MAP (
                                clka => clk,
                                ena => ena_inputs,
                                addra => addra_inputs,
                                douta => douta_inputs
                                );

    --addra_sgn <= signed(addra_weights);        -- KAN TAS BORT
    douta_sgn <= signed(douta_weights);
    --addra_inputs_sgn <= signed(addra_inputs);  -- KAN TAS BORT
    douta_inputs_sgn <= signed(douta_inputs);
    weightsIn(0) <= douta_sgn;
    y <= output_value;

    q_loop : for i in 1 to L-1 generate
        acc(i) <= sum(i-1);
        weightsIN(i) <= weightsOUT(i-1);
    end generate;
    
    PROCESS(input_counter)
    VARIABLE temp_input: SIGNED(M-1 DOWNTO 0);
    BEGIN
        IF (input_counter > p_size+2) THEN
            ena_inputs <= '0';        
        ELSIF(ena_inputs = '1' AND input_counter > 2) THEN              
            temp_input := douta_inputs_sgn;
            pixel_inputs(input_counter-3) <= temp_input;              
        END IF;
    END PROCESS;
   
    PROCESS (addra_weights)
    BEGIN
        IF(addra_weights < 1) THEN
            addra_inputs <= (others => '0');
        ELSE 
            addra_inputs <= addra_inputs + 1;
        END IF;
    END PROCESS;
    
    PROCESS (clk)
    BEGIN
    IF (CLK'EVENT AND CLK = '1') THEN
            addra_weights <= addra_weights + 1;
            input_counter <= input_counter + 1;             
    END IF;
    END PROCESS;
    
end NN;