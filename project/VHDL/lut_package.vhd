LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;
use work.adder_Package.all;

PACKAGE LUT_PACKAGE IS

--CONSTANT K : INTEGER := 2; -- k= # of layers.,
--CONSTANT L : INTEGER := 2; -- k= # of Nodes / Layer.,
--CONSTANT N : INTEGER := 4; -- n= # of coef.,
--CONSTANT M : INTEGER := 4; -- m= # of bits of input and coef.
--TYPE INPUTMATRIX IS ARRAY (K-1 DOWNTO 0) OF INPUTARRAY;
--TYPE INPUTMATRIXARRAY IS ARRAY (L-1 DOWNTO 0) OF INPUTMATRIX;

COMPONENT LUT
      PORT (x: IN SIGNED(M+M-1 DOWNTO 0);
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

use work.LUT_PACKAGE.all;
use work.adder_Package.all;
use work.mac_Package.all;

entity LUT is
      PORT (x: IN SIGNED(M+M-1 DOWNTO 0);
      y: OUT SIGNED(M-1 DOWNTO 0));
end LUT;

architecture NN of LUT is

    SIGNAL tempIn : SIGNED(M+m-1 DOWNTO 0);
    SIGNAL tempOut : SIGNED(M-1 DOWNTO 0);

begin
    
   y <= x(3 downto 0);
   -- y <= "0001";
   -- weightIN(0) <= weight;                -- Sets the first MACs x input to the FIR x input.
   
   -- acc(0)(0)(0) <= (others => '0');  -- Sets the first MACs acc input to zeros 
                                -- as the first addition should not change the first product
    --y <= sum(N);
    
    -- Generates all the connections between each Layer
  --  q_loop : for i in 1 to K-1 generate
   -- q_loop2 : for j in 0 to L-1 generate
   --     acc(i) <= sum;
        --sum(i) <= x(i)(j)
   -- end generate;
  --  end generate;
    
    -- Flip-Flops the last sum of the MACs to the y output
end NN;