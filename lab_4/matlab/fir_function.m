b = fir1(20, [0.08, 0.1], 'bandpass');
[c,d] = butter(4, 0.045, 'high');