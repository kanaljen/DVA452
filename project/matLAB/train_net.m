%%%%%%%%%%%%%%%Training a MLP NN
load('ex3data1.mat');
x1=X';% Input Data Set
y1=dummyvar(y');%Output Data Set
y1 = y1';
net = patternnet([10], 'traingdx');
net.inputs{1}.processFcns = {'mapminmax'};
%net.inputs.processFcns = {'mapminmax'};
net = train(net, x1, y1);

W_inputs = net.IW{1};
W_layer1 = net.LW{2};
