function x = InformationSource(n)

letters = ['a', 'b', 'c', 'd', 'e', 'f'];
weights = [1/2, 1/4, 1/8, 1/16, 1/32, 1/32];
x = randsample(letters, n, true, weights);

end

