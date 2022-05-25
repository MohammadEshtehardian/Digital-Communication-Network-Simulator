function y = PulseShaping(x, s0, s1)

s0 = str2num(s0);
s1 = str2num(s1);

if length(s0) ~= length(s1)
    disp('Shapes must have same lengths.')
else
    n = length(x);
    m = length(s0);
    y = zeros(1, n*m);
    for i=0:n-1
        for j=1:m
            if x(i+1)==1
                y(i*m+j)=s1(j);
            else
                y(i*m+j)=s0(j);
            end
        end
    end
end
end

