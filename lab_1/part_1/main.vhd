LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
----------------------------------------------
ENTITY ALU IS
  PORT (a, b: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
 sel: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
 cin: IN STD_LOGIC;
 y: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
 END ALU;
----------------------------------------------
ARCHITECTURE dataflow OF ALU IS
SIGNAL arith, logic: STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
----- Arithmetic unit: ------
WITH sel(2 DOWNTO 0) SELECT
   arith <=   a WHEN "000",
            a+1 WHEN "001",
            a-1 WHEN "010",
              b WHEN "011",
            b+1 WHEN "100",
            b-1 WHEN "101",
            a+b WHEN "110",
        a+b+cin WHEN OTHERS;




 ----- Logic unit: -----------
 WITH sel(2 DOWNTO 0) SELECT
    logic <=   NOT a WHEN "000",
               NOT b WHEN "001",
             a AND b WHEN "010",
              a OR b WHEN "011",
            a NAND b WHEN "100",
             a NOR b WHEN "101",
             a XOR b WHEN "110",
       NOT (a XOR b) WHEN OTHERS;
-------- Mux: ---------------
  WITH sel(3) SELECT
    y <= arith WHEN '0',
         logic WHEN OTHERS;
 END dataflow;