function L = laplacianMatrix(P)

A = adjacencyMatrix(P);
D = degreeMatrix(P);
L = D - A;

end