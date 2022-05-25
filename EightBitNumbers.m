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


input = randi(256, 1, 100)-1;
b = SourceGenerator(input);
[b1, b2] = Divide(b);

x1 = PulseShaping(b1, s0, s1);
x2 = PulseShaping(b2, s0, s1);

xc = AnalogMod(x1, x2, fs, fc);

sigma = 0:5:100;
Var = zeros(1, length(sigma));
for i=1:length(sigma)
    y0 = Channel(xc, fs, fc_channel, BW_channel);
    energy = sum(y0.^2);
    SNR = 20*log10(energy/sigma(i)^2);
    y = awgn(y0, SNR, 20*log10(energy));
    [y1, y2] = AnalogDemod(y, fs, fc, fc);
    [out10, out11, b1_hat] = MatchedFilt(y1, s0, s1);
    [out20, out21, b2_hat] = MatchedFilt(y2, s0, s1);
    b_hat = Combine(b1_hat, b2_hat);
    output = OutputDecoder(b_hat);
    Var(i) = mean((input-output).^2);
end

figure();
plot(sigma.^2, Var);
grid();
title('Variance of Error vs Variance of the Noise', 'interpreter', 'latex');
xlabel('$\sigma_n^2$', 'interpreter', 'latex');
ylabel('Variance', 'interpreter', 'latex');


% plot the error distribution
sigma = [3 5 10 20];
for i=1:length(sigma)
    figure();
    dist = zeros(1, length(input)+1);
    iter = 25;
    for k=1:iter
        y0 = Channel(xc, fs, fc_channel, BW_channel);
        energy = sum(y0.^2);
        SNR = 20*log10(energy/sigma(i)^2);
        y = awgn(y0, SNR, 20*log10(energy));
        [y1, y2] = AnalogDemod(y, fs, fc, fc);
        [out10, out11, b1_hat] = MatchedFilt(y1, s0, s1);
        [out20, out21, b2_hat] = MatchedFilt(y2, s0, s1);
        b_hat = Combine(b1_hat, b2_hat);
        output = OutputDecoder(b_hat);
        l = sum(output-input==0);
        dist(l+1) = dist(l+1)+1;
    end
    dist = dist/iter;
    stem(0:1:100, dist, 'MarkerFaceColor', 'Blue');
    title('Distribution of Error', 'interpreter', 'latex');
    xlabel('Number of Right Detections', 'interpreter', 'latex');
    ylabel('Probability of Error', 'interpreter', 'latex');
end




