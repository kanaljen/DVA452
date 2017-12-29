from convert_func import *

strWeights = []
binWeights = []
outputBits = 16

# Read each line to list and remove |n
with open('../matLAB/OneLayer/inputsWeights.dat','r') as f:
    for line in f:
        if '-' in line:
            strWeights.append(line[:9])
        else:
            strWeights.append(line[:8])

# Convert weights from string to binary
for i in range(0,len(strWeights)):
    floatWeight = float(strWeights[i])
    binWeights.append(decToBinary(floatWeight,outputBits))

# Write weights to file
with open('inputWeights.coe','w') as f:
    for j in range(0,len(binWeights)):
        f.write(binWeights[j] + ',')
