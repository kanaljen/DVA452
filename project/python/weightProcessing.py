from convert_func import *

outputBits = 16
c = 0
for w in ['layer','input']:
    strWeights = []
    binWeights = []
    # Read each line to list and remove |n
    with open('../matLAB/OneLayer/'+w+'Weights.dat','r') as f:
        for line in f:
            if '-' in line:
                strWeights.append(line[:9])
            else:
                strWeights.append(line[:8])


    # Convert weights from string to binary
    for i in range(0,len(strWeights)):
        floatWeight = float(strWeights[i])
        binWeights.append(decToBinary(floatWeight,outputBits,7))

    with open(w+'Weights.coe','w') as f:
        for j in range(0,len(binWeights)):
            f.write(binWeights[j] + '\n')

    print("Found " + str(len(strWeights))+ ' ' +w + 'Weights')
    print("Wrote " + str(len(binWeights)) + ' ' + w + 'Weights')
