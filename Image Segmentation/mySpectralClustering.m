function clusterIdx = mySpectralClustering(anAffinityMat,k)
%% mySpectralClustering


%   Inputs:
%   anAffinityMat: A (MN)x(MN) matrix, which contains the affinity matrix of the image.
%   k: The request number of clusters.
 

%    Output:
%   clusterIdx: An array (MN)x1, which contains the cluster label of each pixel.
%
% 1. compute the diagonial of the affinity Matrix. 
% 2. compute Laplacian matrix which shows the smoothness of the affinity Matrix.
% 3. compute the k smallest-real (with the correct option) eigenvalues (and eigenvectors) 
% 4. group them with kmean into k-clusters.
%% Code
    rng(1) %random seed input for kmeans algorithm
    D = diag( sum(anAffinityMat(:,:)) );     
    Laplacian = D - anAffinityMat;
    [eigenVectors, ~] =  eigs(Laplacian,k,'smallestreal');
    clusterIdx = kmeans(eigenVectors,k);
end