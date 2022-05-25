function [out0, out1, bits] = MatchedFilt(x,s0,s1)

s0 = str2num(s0);
s1 = str2num(s1);

M = length(s0);
N = length(x);
pulse_number = N/M;

mf0 = flip(s0);
mf1 = flip(s1);

out0 = conv(x, mf0, 'same');
out0 = out0 / max(out0);
out1 = conv(x, mf1, 'same');
out1 = out1 / max(out1);

bits = zeros(1, pulse_number);
y = zeros(1, N);

for i=1:pulse_number-1
    k = M*(i-1)+1;
    if mean(out1(k:k+M-1))>0
        bits(i) = 1;
    else
        bits(i) = 0;
    end
end

end

