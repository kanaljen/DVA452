library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

package FIR_Package is

constant N : INTEGER := 4; -- n= # of coef.,
constant M : INTEGER := 4; -- m= # of bits of input and coef.
TYPE coefficient IS ARRAY (N-1 DOWNTO 0) OF SIGNED(M-1 DOWNTO 0);

component FIR
      PORT (x: in SIGNED (M-1 DOWNTO 0);
            coef: in coefficient;
            clk, rst: in STD_LOGIC;
            y: out SIGNED(M+M-1 DOWNTO 0));
end component;

end package;

---------------------------------------
---------- FIR ------------------------
---------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use work.FIR_Package.all;
use work.MAC_Package.all;

entity FIR is
    PORT (x: in SIGNED (M-1 DOWNTO 0);
          coef: in coefficient;
          clk, rst: in STD_LOGIC;
          y: out SIGNED(M+M-1 DOWNTO 0) := (others => '0'));
end FIR;

architecture filter of FIR is

    signal xin : coefficient;   -- Holds the x inputs for each MAC
    signal q : coefficient;     -- Holds the q outputs for each MAC
    
    type matrix is array (0 to N-1) of SIGNED(N+N-1 downto 0); 
    signal sum : matrix;        -- Holds the sum outputs for each MAC
    signal acc : matrix;        -- Holds the acc input for each MAC

begin
    
    -- Generates each MAC in the FIR
    mac_loop : for i in 0 to N-1 generate
        MU : MAC_Unit port map( xIn => xin(i), 
                                coef => coef(i), 
                                acc => acc(i),
                                clk => clk, 
                                rst => rst,
                                q => q(i),
                                sum => sum(i));
    end generate;
    
    xin(0) <= x;                -- Sets the first MACs x input to the FIR x input.
    acc(0) <= (others => '0');  -- Sets the first MACs acc input to zeros 
                                -- as the first addition should not change the first product
    
    -- Generates all the connections between each MAC
    q_loop : for i in 1 to N-1 generate
        xin(i) <= q(i-1);
        acc(i) <= sum(i-1);
    end generate;
    
    -- Flip-Flops the last sum of the MACs to the y output
    PROCESS(clk) 
    BEGIN
        IF (clk'EVENT AND CLK = '1') THEN
            y <= sum(N-1);
        END IF;
    END PROCESS;
end filter;