% Input weights
load IW.mat
rIW = round(W_inputs,5); % Round numbers
vIW = reshape(rIW,1,[]); % Matrix to vector 
file = fopen('inputWeights.dat', 'wt');
fprintf(file,'%0.6f\n', vIW);
fclose(file);
clear;
clc;

% Layer weights
load LW.mat
rLW = round(W_layer1,5); 
vLW = reshape(rLW,1,[]);
file = fopen('layerWeights.dat', 'wt');
fprintf(file,'%0.6f\n', vLW);
fclose(file);
clear;
clc;