function xc = AnalogMod(x1, x2, fs, fc)

n = length(x1);
t = 1/fs:1/fs:n*1/fs;
xc = x1.*cos(2*pi*fc*t)+x2.*sin(2*pi*fc*t);

end

