
def binaryToDecimal(binary,intbit):
    """"Function converts binary fraction to decimal fraction"""

    dec = 0


    # Only sign bit
    if len(binary) < 1:
        return 0

    # For positive numbers
    if(binary[0] == '0'):
        for i in range(1,len(binary)):
            if(binary[i] == '1'):
                dec += 1/(2**(i-(intbit)))

        return dec

    # For negative numbers
    elif(binary[0] == '1'):
        for i in range(1,len(binary)):
            if(binary[i] == '0'):
                dec += (1/(2**(i-(intbit))))
        return dec*-1


def decToBinary(dec,bits,intbit):
    """"Function converts decimal fractions to binary fractions of bits lenth"""

    # For negative numbers
    if dec < 0:

        binary = '1'
        dec = dec*-1

        for i in range(1, bits):
            if (dec - (1 / (2 ** (i-intbit))) >= 0):
                dec = dec - 1 / (2 ** (i-intbit))
                binary += '0'

            else:
                binary += '1'

    # For positive numbers
    elif dec > 0:
        binary = '0'

        for i in range(1, bits):
            if (dec - (1 / (2 ** (i-intbit))) >= 0):
                dec = dec - 1 / (2 ** (i-intbit))
                binary += '1'

            else:
                binary += '0'

    # Dec is zero
    else:
        return '0'*bits

    return binary
