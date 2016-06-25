function D = degreeMatrix(P)

A = ceil(P); % all weights to 1
D = diag(sum(A,1));

end