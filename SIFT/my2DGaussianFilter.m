function myGFilter = my2DGaussianFilter(K,sigma)
% Summary: Gaussian Filter 2D
% Inputs : K - the size of the filter
%          sigma - the standard deviation of the Gaussian distribution
% Output : myGFilter : The KxK gaussian Filter (matrix)
% gaussian kernel is computed gKernel
sum = 0;
mu = K/2;
alpha = 1 / (2*pi*sigma*sigma);
%%Get Kernel
gkernel = zeros(K,K);
for i = 1:K
    for j = 1:K
        gkernel(i,j) = alpha * exp(-((j - mu)*(j - mu) + (i - mu)*(i - mu))/(2*sigma*sigma)); 
        sum = sum + gkernel(i,j);
    end
end

%% NORMALIZE by dividing with the sum and the max
%for i = 1:K
%    for j = 1:K
%        gkernel[i][j] = gkernel[i][j]/sum;
%    end
%end
%or better
gKernelNorm = gkernel./sum;


myGFilter = gKernelNorm;
end

