
from math import exp

F = open('vhdl_code','w')

head = 's_x <= '
F.write(head)


bits = 16

for i in range(0, int(2**bits)):
    n = bin(i)[2:]

    if  i == 0:
        pre = ""
    else:
        pre = "               "
    if len(n) < bits:
        for j in range(0,bits - len(n)):
            n = '0' + n

    x =  bin(int(1/(1 + exp(-i))*100))[2:]
    if len(x) < bits:
        for j in range(0,bits - len(x)):
            x = '0' + x


    txt = pre + '"' +  x + '"' +  " when x = " + '"'+ n + '"' + ' else' + '\n'
    F.write(txt)




