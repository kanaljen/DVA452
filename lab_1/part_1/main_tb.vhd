LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.all;

---------------
ENTITY TB IS
END TB;

ARCHITECTURE tb OF TB IS

SIGNAL in1, in2, y: STD_LOGIC_VECTOR (7 DOWNTO 0):=(OTHERS => '0');
SIGNAL s: STD_LOGIC_VECTOR (3 DOWNTO 0):=(OTHERS => '0');
SIGNAL c: STD_LOGIC:='0';

BEGIN

PROCESS
 BEGIN

  ---- testcase 1
  WAIT for 10 ns;
  
  in1 <= "10000000";
  in2 <= "10000000";
  s <= "0000";
  c <= '0';

  
  ---- testcase 2
  WAIT for 10 ns;

  in1 <= "11000000";
  in2 <= "11000000";
  s <= "0001";
  c <= '0';
  
  ---- provide at least 10 more testcases



  WAIT;

 END PROCESS;
   

alu1: ENTITY ALU port map (in1, in2, s, c, y);

END tb;