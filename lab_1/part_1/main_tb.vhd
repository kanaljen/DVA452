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
    
    
    ---- arith testcases 1 - 8
    ---- in1 is always = 4 and in2 always = 2
    
    ---- testcase 1
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0000";
    c <= '0';
    WAIT for 10 ns;
      
    ---- testcase 2
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0001";
    c <= '0';
    WAIT for 10 ns;

    ---- testcase 3
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0010";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 4
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0011";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 5
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0100";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 6
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0101";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 7
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0110";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 8
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "0111";
    c <= '1';
    WAIT for 10 ns;
    
    ---- logic testcases 9 - 16 TODO: Hur funkar logic???
    ---- testcase 9
    in1 <= "00000001";
    in2 <= "00000000";
    s <= "1000";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 10
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1001";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 11
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1010";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 12
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1011";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 13
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1100";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 14
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1101";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 15
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1110";
    c <= '0';
    WAIT for 10 ns;
    
    ---- testcase 16
    in1 <= "00000100";
    in2 <= "00000010";
    s <= "1111";
    c <= '0';
    WAIT for 10 ns;



  WAIT;

 END PROCESS;
   

alu1: ENTITY ALU port map (in1, in2, s, c, y);

END tb;