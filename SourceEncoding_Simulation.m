clc; clear; close all;

% parameters
n = 1:500; % number of letters
H = zeros(1, length(n)); % vector for save LB(n)/n

for i=n
    % Generate Information
    x = InformationSource(i);
    % Source Encoding
    b = SourceEncoder(i, x);
    % Source Decoder
    y = SourceDecoder(b);
    % Save LB(n)/n
    H(i) = length(b) / i;
end

figure();
plot(n, H, 'b');
grid();
title('Source Encoder Simulation', 'interpreter', 'latex');
xlabel('$n$', 'interpreter', 'latex');
ylabel('$H_n(X)$', 'interpreter', 'latex');

