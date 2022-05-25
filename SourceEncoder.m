function b = SourceEncoder(n, x)

b = [];
for i=1:n
    if x(i) == 'a'
        b = [b 0];
    elseif x(i) == 'b'
        b = [b [1 1]];
    elseif x(i) == 'c'
        b = [b [1 0 1]];
    elseif x(i) == 'd'
        b = [b [1 0 0 1]];
    elseif x(i) == 'e'
        b = [b [1 0 0 0 1]];
    elseif x(i) == 'f'
        b = [b [1 0 0 0 0]];
    end
end

end

