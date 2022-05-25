function yc = Channel(x, fs, fc, BW)

yc = bandpass(x, [fc-BW/2, fc+BW/2], fs);

end

