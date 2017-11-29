library ieee;
use ieee.std_logic_1164.all;

entity generic_mult is
generic (N: integer; M: integer);
port ( a    :  in  std_logic_vector(N-1 downto 0);
       b    :  in  std_logic_vector(M-1 downto 0);
       prod :  out std_logic_vector(M+N-1 downto 0) );
end entity generic_mult;

architecture behavioral of generic_mult is

-- Components
component mult is
port (
    a    :  in std_logic;
    b    :  in std_logic;
    pin  :  in std_logic;
    cin  :  in std_logic;
    pout :  out std_logic;
    cout :  out std_logic );
end component;

-- Signals
type mem_word is array (0 to M-1) of std_logic_vector(N-1 downto 0);
signal cin  : mem_word;
signal cout : mem_word;
signal pin  : mem_word;
signal pout : mem_word;

begin

    m_loop: for i in 0 to M-1 generate
        n_loop: for j in 0 to N-1 generate
            mult_inst : mult
            port map (
                a    => a(j),
                b    => b(i),
                pin  => pin(i)(j),
                cin  => cin(i)(j),
                pout => pout(i)(j),
                cout => cout(i)(j) );
        end generate;
    end generate;

    cin_init: for j in 0 to N-1 generate 
        cin(0)(j) <= '0'; 
    end generate;

    cin_mloop: for i in 1 to M-1 generate
        cin_nloop: for j in 0 to N-2 generate 
            cin(i)(j) <= pout(i-1)(j+1); 
        end generate;
        cin(i)(N-1) <= cout(i-1)(N-1);
    end generate;

    pin_mloop: for i in 0 to M-1 generate 
        pin(i)(0) <= '0'; 
        pin_nloop: for j in 1 to N-1 generate 
            pin(i)(j) <= cout(i)(j-1); 
        end generate;
    end generate;

    prod_loop: for j in 0 to M-1 generate
        prod(j) <= pout(j)(0);
    end generate;

    prod(M+N-2 downto M) <= pout(M-1)(N-1 downto 1);
    prod(M+N-1) <= cout(M-1)(N-1);

end behavioral;