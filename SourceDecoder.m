function x = SourceDecoder(b)

x = [];
while ~isempty(b)
    if b(1)==0
        x = [x 'a'];
        b = b(2:length(b));
    elseif b(1)==1 && b(2)==1
        x = [x 'b'];
        b = b(3:length(b));
    elseif b(1)==1 && b(2)==0 && b(3)==1
        x = [x 'c'];
        b = b(4:length(b));
    elseif b(1)==1 && b(2)==0 && b(3)==0 && b(4)==1
        x = [x 'd'];
        b = b(5:length(b));
    elseif b(1)==1 && b(2)==0 && b(3)==0 && b(4)==0 && b(5)==1
        x = [x 'e'];
        b = b(6:length(b));
    elseif b(1)==1 && b(2)==0 && b(3)==0 && b(4)==0 && b(5)==0
        x = [x 'f'];
        b = b(6:length(b));
    end
end

end

