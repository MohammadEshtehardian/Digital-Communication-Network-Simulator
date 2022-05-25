clear; clc; close all;

% parameters
fs = 1e6;
Tb = 1e-3;
fc = 10e3;
fc_channel = 10e3;
BW_channel = 1e3;
f0 = 1.5e3;
f1 = 1e3;

% Generate Pulse Shapes
t = (1:Tb*fs)*(1/fs);
s0 = num2str(sin(2*pi*f0*t));
s1 = num2str(sin(2*pi*f1*t));


b = randi(2, 1, 1000)-1;
[b1, b2] = Divide(b);

x1 = PulseShaping(b1, s0, s1);
x2 = PulseShaping(b2, s0, s1);

xc = AnalogMod(x1, x2, fs, fc);

sigma = 0:5:100;
error_probability = zeros(1, length(sigma));
for i=1:length(sigma)
    y0 = Channel(xc, fs, fc_channel, BW_channel);
    energy = sum(y0.^2);
    SNR = 20*log10(energy/sigma(i)^2);
    y = awgn(y0, SNR, 20*log10(energy));
    [y1, y2] = AnalogDemod(y, fs, fc, fc);
    [out10, out11, b1_hat] = MatchedFilt(y1, s0, s1);
    [out20, out21, b2_hat] = MatchedFilt(y2, s0, s1);
    b_hat = Combine(b1_hat, b2_hat);
    error_probability(i) = sum(abs(b-b_hat))/length(b);
end

figure();
plot(sigma, error_probability);
grid();
title('Probability of Error vs Variance', 'interpreter', 'latex');
xlabel('$\sigma$', 'interpreter', 'latex');
ylabel('Probability of Error', 'interpreter', 'latex');




