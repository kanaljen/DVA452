
from math import exp
from convert_func import *



F = open('vhdl_code','w')

head = 's_y <= '
F.write(head)


inbits = 16
outbits = 16
intbit = 7

# The negative side
for i in range(0, int(2**(inbits-1))):
    n = bin(i)[2:]
    n = '0'*(inbits-len(n)-1) + n
    n = '1' + n

    x = decToBinary(1/(1 + (exp(-binaryToDecimal(n,intbit)))),outbits,intbit)

    txt = '"' + str(x) + '"' + " when s_x = " + '"' + n + '"' + ' else' + '\n'
    F.write(txt)


zero = '"' + (intbit+1)*'0' + '1'  + (outbits-(intbit+2)) * '0' + '" when s_x = ' + '"' + inbits*'0' + '"' + ' else' + '\n'
F.write(zero)

# Positive side
for i in range(1, int(2 ** (inbits - 1))):
    n = bin(i)[2:]
    n = '0' * (inbits - len(n) - 1) + n
    n = '0' + n

    x = decToBinary(1/(1 + (exp(-binaryToDecimal(n,7)))),outbits,7)

    txt = '"' + str(x) + '"' + " when s_x = " + '"' + n + '"' + ' else' + '\n'
    F.write(txt)

# Others
others = "(others => '0');"
F.write(others)

