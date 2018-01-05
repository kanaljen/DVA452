%%%%%%%%%%%%%%%Training a MLP NN
load('ex3data1.mat');
x1=X';% Input Data Set
y1=dummyvar(y');%Output Data Set
y1 = y1';
% Create Network
net = patternnet([10], 'traingdx');
% Change transfer func for layers
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';
% Dont remove zero weights
net.inputs{1}.processFcns = {'mapminmax'};

net = train(net, x1, y1);

% Export weights
W_inputs = net.IW{1};
W_layer1 = net.LW{2};
save('OneLayer/IW.mat','W_inputs')
save('OneLayer/LW.mat','W_layer1')


