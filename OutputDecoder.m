function x = OutputDecoder(b)

b = reshape(b, [], 8);
x = bi2de(b, 'right-msb');
x = reshape(x, 1, []);

end

