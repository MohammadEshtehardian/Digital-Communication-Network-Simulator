clear; clc; close all;

% parameters
fs = 1e6;
Tb = 1e-3;
fc = 10e3;
fc_channel = 10e3;
BW_channel = 1e3;

% Generate Pulse Shapes
s = ones(1, floor(Tb/(1/fs)));
s0 = num2str(-s);
s1 = num2str(s);


b = randi(2, 1, 1000)-1;
[b1, b2] = Divide(b);

x1 = PulseShaping(b1, s0, s1);
x2 = PulseShaping(b2, s0, s1);

xc = AnalogMod(x1, x2, fs, fc);

sigma = [0.1 0.5 1 1.5 5 10];
for i=1:length(sigma)
    y0 = Channel(xc, fs, fc_channel, BW_channel);
    energy = sum(y0.^2);
    SNR = 20*log10(energy/sigma(i)^2);
    y = awgn(y0, SNR, 20*log10(energy));
    [y1, y2] = AnalogDemod(y, fs, fc, fc);
    [out10, out11, b1_hat] = MatchedFilt(y1, s0, s1);
    [out20, out21, b2_hat] = MatchedFilt(y2, s0, s1);
    figure();
    scatter(b1_hat, b2_hat);
    title('Scatter Plot', 'interpreter', 'latex');
    xlabel('$\hat{b_1}$', 'interpreter', 'latex');
    ylabel('$\hat{b_2}$', 'interpreter', 'latex');
    axis([-1 2 -1 2]);
end




