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
          y: out SIGNED(M+M-1 DOWNTO 0));
end FIR;

architecture filter of FIR is

    signal xin : coefficient;
    signal q : coefficient;
    
    type matrix is array (0 to N-1) of SIGNED(N+N-1 downto 0); 
    signal sum : matrix;
    signal acc : matrix;

begin
    
    MU : MAC_Unit port map( xIn => x, 
                            coef => coef(0), 
                            acc => acc(0),
                            clk => clk, 
                            rst => rst,
                            q => q(0),
                            sum => sum(0));
    
--    mac_loop : for i in 1 to N-1 generate
--        MU : MAC_Unit port map( xIn => xin(i-1), 
--                                coef => coef(i), 
--                                acc => acc(i),
--                                clk => clk, 
--                                rst => rst,
--                                q => q(i),
--                                sum => sum(i));
--    end generate;
    
    
    acc(0) <= (others => '0');
--    q_loop : for i in 1 to N-1 generate
--        xin(i) <= q(i-1);
--        acc(i) <= sum(i-1);
--    end generate;

    y <= sum(0);
    
end filter;