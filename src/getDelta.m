function delta = getDelta(A1, An)

% First element of An is actually A2

delta = 0;
n = 2;

for i = 1:length(An)
    
    sol = n*(An(i)/A1)^2;
    delta = delta + sol;
    
    n = n +1;

end