function [b1,b2] = Divide(b)

n = length(b);
if mod(n, 2) == 0
    b1 = b(1:n/2);
    b2 = b(n/2+1:n);
else
    disp('Length of input must be an even number.');
end

end

