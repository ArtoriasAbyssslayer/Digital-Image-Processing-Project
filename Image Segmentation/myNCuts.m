function clusterIdx = myNCuts(anAffinityMat,k)
%nCuts
%Inputs:
%   anAffinityMat: A (MN)x(MN) matrix, which contains the affinity matrix of the image.
%   k: The request number of clusters.
%Output:
%   clusterIdx: An array (MN)x1, which contains the cluster label of each pixel.
%
% 1. compute the diagonial of the affinity Matrix. 
% 2. compute Laplacian matrix which shows the smoothness of the affinity Matrix.
% 3.Compute the k smallest-real eigenvalues (and eigenvectors) by 
% 4.solving the generalized eigenvalue problem and grouped them into k-clusters.
%The difference with spectralClustering is that we solve the generalized problem Lx=lambdaDx and
%so the eigs takes the parameter D .
    rng(1)
    D = diag( sum(anAffinityMat(:,:)) );     
    Laplacian = D - anAffinityMat;
    [eigenVectors, ~] =  eigs(Laplacian,D,k,'smallestreal');
    clusterIdx = kmeans(eigenVectors,k);
end