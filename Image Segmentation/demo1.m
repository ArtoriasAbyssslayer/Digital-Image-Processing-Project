clear 
clc
rng(1)
load('dip_hw_2.mat');
%% demo 1 : Compute (Spectral) Clustering tags for k = 2, 3, 4 
ClusterWith2Tags = mySpectralClustering(d1a,2); 
ClusterWith3Tags = mySpectralClustering(d1a,3);
ClusterWith4Tags = mySpectralClustering(d1a,4);

%% Present the Spectral Clustering of d1a 
figure1 = figure('Name', 'd1a Spectral Clustering','NumberTitle','off');
title('Spectral Clustering for d1a')
subplot(2,2,1)
imshow(d1a)
title('Original Photo')
subplot(2,2,2)
ClusterWith2Tags = reshape(ClusterWith2Tags, [3 4]);
ClusterWith2Tags = ClusterWith2Tags ./ max(max(ClusterWith2Tags));
imshow(ClusterWith2Tags')
title('Clustering for k = 2')
subplot(2,2,3)
ClusterWith3Tags = reshape(ClusterWith3Tags, [3 4]);
ClusterWith3Tags = ClusterWith3Tags ./ max(max(ClusterWith3Tags));
imshow(ClusterWith3Tags')
title('Clustering for k = 3')
subplot(2,2,4)
ClusterWith4Tags = reshape(ClusterWith4Tags, [3 4]);
ClusterWith4Tags = ClusterWith4Tags ./ max(max(ClusterWith4Tags));
imshow(ClusterWith4Tags')
title('Clustering for k = 4')