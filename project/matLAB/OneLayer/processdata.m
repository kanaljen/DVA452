% Input weights
load IW.mat
W_inputs = W_inputs';
rIW = round(W_inputs,5); % Round numbers
vIW = reshape(rIW,1,[]); % Matrix to vector
vIW = fliplr(vIW); % Flip vectors
file = fopen('inputWeights.dat', 'wt');
fprintf(file,'%0.6f\n', vIW);
fclose(file);

% Layer weights
load LW.mat
W_layer1 = W_layer1';
rLW = round(W_layer1,5); 
vLW = reshape(rLW,1,[]);
vIW = fliplr(vIW);
file = fopen('layerWeights.dat', 'wt');
fprintf(file,'%0.6f\n', vLW);
fclose(file);

% Clean
clear
clc
