
from math import exp
from convert_func import *



F = open('vhdl_code','w')

head = 's_x <= '
F.write(head)


inbits = 8
outbits = 8

# The negative side
for i in range(0, int(2**(inbits-1))):
    n = bin(i)[2:]
    n = '0'*(inbits-len(n)-1) + n
    n = '1' + n

    x = decToBinary(1/(1 + (exp(-binaryToDecimal(n)))),8)

    txt = '"' + str(x) + '"' + " when x = " + '"' + n + '"' + ' else' + '\n'
    F.write(txt)

for i in range(1, int(2 ** (inbits - 1))):
    n = bin(i)[2:]
    n = '0' * (inbits - len(n) - 1) + n
    n = '0' + n

    x = decToBinary(1/(1 + (exp(-binaryToDecimal(n)))),8)

    txt = '"' + str(x) + '"' + " when x = " + '"' + n + '"' + ' else' + '\n'
    F.write(txt)