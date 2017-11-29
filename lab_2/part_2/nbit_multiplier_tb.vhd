library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;


architecture arch of tb is

	component nbit_multi is
	
		generic (N: integer; M: integer);
	  		port(a : in std_logic_vector (N-1 downto 0);
	  			 b : in std_logic_vector (M-1 downto 0);
	  			 p : out std_logic_vector (N+M-1 downto 0));
	end component;

signal DATA_BYTE : std_logic_vector(N-1 downto 0);

begin 

	UUT: nbit_multi generic map (N => 8) port map(a,b => DATA_BYTE);


end architecture ; -- arch