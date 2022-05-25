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

% Generate Input Signal 
b = randi(2, 1, 1000)-1;
figure();
stem(b, 'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'black');
axis([0 20 -2 2]);
title('Input Signal', 'interpreter', 'latex');
xlabel('$n$', 'interpreter', 'latex');
ylabel('$b$', 'interpreter', 'latex');

% Divide
[b1, b2] = Divide(b);
figure();
subplot(2, 1, 1);
stem(b1, 'MarkerFaceColor', 'green'); axis([0 20 -2 2]);
ylabel('$b_1$', 'interpreter', 'latex');
subplot(2, 1, 2);
stem(b2, 'MarkerFaceColor', 'red'); axis([0 20 -2 2]);
sgtitle('$b_1$ and $b_2$', 'interpreter', 'latex');
xlabel('$n$', 'interpreter', 'latex');
ylabel('$b_2$', 'interpreter', 'latex');

% Pulse Shaping
x1 = PulseShaping(b1, s0, s1);
x2 = PulseShaping(b2, s0, s1);
figure();
subplot(2, 1, 1);
plot(x1); axis([0 100*Tb/(1/fs) -2 2]);
ylabel('$x_1$', 'interpreter', 'latex');
subplot(2, 1, 2);
plot(x2); axis([0 100*Tb/(1/fs) -2 2]);
sgtitle('$x_1$ and $x_2$', 'interpreter', 'latex');
xlabel('$t(ms)$', 'interpreter', 'latex');
ylabel('$x_2$', 'interpreter', 'latex');

% Analog Modulation
xc = AnalogMod(x1, x2, fs, fc);
figure();
plot(xc);
grid();
title('Modulated Signal', 'interpreter', 'latex');
xlabel('$t(ms)$', 'interpreter', 'latex');
ylabel('$x_c$', 'interpreter', 'latex');
axis([0 10000 -2 2]);

% Channel
y = Channel(xc, fs, fc_channel, BW_channel);
figure();
plot(y);
grid();
title('Modulated Signal At the Reciver', 'interpreter', 'latex');
xlabel('$t(ms)$', 'interpreter', 'latex');
ylabel('$y$', 'interpreter', 'latex');
axis([0 10000 -2 2]);

% Analog Demodulation
[y1, y2] = AnalogDemod(y, fs, fc, fc);
figure();
subplot(2, 1, 1);
plot(y1); axis([0 100*Tb/(1/fs) -2 2]);
ylabel('$y_1$', 'interpreter', 'latex');
subplot(2, 1, 2);
plot(y2); axis([0 100*Tb/(1/fs) -2 2]);
sgtitle('$y_1$ and $y_2$', 'interpreter', 'latex');
xlabel('$t(ms)$', 'interpreter', 'latex');
ylabel('$y_2$', 'interpreter', 'latex');

% Passing Signals Through Matched Filter
[out10, out11, b1_hat] = MatchedFilt(y1, s0, s1);
[out20, out21, b2_hat] = MatchedFilt(y2, s0, s1);
figure();
subplot(2, 1, 1);
stem(b1_hat, 'MarkerFaceColor', 'green'); axis([0 20 -2 2]);
ylabel('$\hat{b_1}$', 'interpreter', 'latex');
subplot(2, 1, 2);
stem(b2_hat, 'MarkerFaceColor', 'red'); axis([0 20 -2 2]);
sgtitle('$\hat{b_1}$ and $\hat{b_2}$', 'interpreter', 'latex');
xlabel('$n$', 'interpreter', 'latex');
ylabel('$\hat{b_2}$', 'interpreter', 'latex');

% Combine b1_hat and b2_hat
b_hat = Combine(b1_hat, b2_hat);
figure();
stem(b_hat, 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'blue');
axis([0 20 -2 2]);
title('Recieved Signal After Process', 'interpreter', 'latex');
xlabel('$n$', 'interpreter', 'latex');
ylabel('$\hat{b}$', 'interpreter', 'latex');
