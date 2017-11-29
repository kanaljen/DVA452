library ieee;  
use ieee.std_logic_1164.all;  

entity mult is  
port ( a     :  in std_logic;  
       b     :  in std_logic;  
       pin   :  in std_logic;    -- product in  
       cin   :  in std_logic;    -- carry in  
       pout  :  out std_logic;   -- product out
       cout  :  out std_logic ); -- carry out  
end mult;  

architecture mult of mult is
begin  
    pout <= (a and b) xor cin xor pin;
    cout <= (a and b and cin) or (a and b and pin) or (cin and pin);
end mult;