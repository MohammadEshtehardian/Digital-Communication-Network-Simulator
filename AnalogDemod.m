function [y1, y2] = AnalogDemod(xc,fs,BW,fc)

t = 1/fs:1/fs:length(xc)/fs;
y1 = lowpass(xc.*cos(2*pi*fc*t), BW, fs);
y2 = lowpass(xc.*sin(2*pi*fc*t), BW, fs);

end

