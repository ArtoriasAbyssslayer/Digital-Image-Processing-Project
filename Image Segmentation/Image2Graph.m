function myAffinityMat = Image2Graph(imIn)
%% Image2Graph function
% Inputs: 
%   inIn : A MxNxn  image {matrix}, which contains the whole image (MXN
%   size and n channels)
% Output:
%   myAffinityMat : The affinity matrix of the image

%% Code breakdown
% To make the code easier to develop i convert the MxNxn inIn matrix 
% to n MxN matrices base on the rows (1,1,:);(1,1,2);
% The calculation of brightness difference is done for each row is done with the function vecnorm %vecnorm(A) returns the 2-norm or Euclidean norm of Avecnorm(A) returns the 2-norm or Euclidean norm of A
% Due to this convertion of the input matrix each row is pixel of the
% newMatrix and the access of the matrix is rowWise if we can simply tell this.
% matrix and i can easily take the vecnorm with a loop.
%% Code Start
    [M,N,n] = size(imIn);
    partArray = cell(1,2); 
    myAffinityMat = zeros(M * N,  M * N);
    for ch = 1:n
        partArray{ch} = imIn(:,:,ch);
        partArray{ch} = partArray{ch}';
        partArray{ch} = reshape(partArray{ch}, [], 1);
    end
    newArray = [partArray{1:end}];
    
    for px = 1:M*N
         currentPixVec = newArray(px,:); %take the row
         for tempPix = px : M*N       %temp pixel-row is the one im doing the calculation of norm2 with currentPix
             d = vecnorm(newArray(tempPix,:) - currentPixVec);
             myAffinityMat(px,tempPix) =     1/(exp(d));   %h metrikh einai = 1/e^d
         end
    end
       
%Add the two symmetrical Matrices and substruct the diagonal part that has
%mistakenly been added -  eye function used to take a the appropriate
%diagonal part 
myAffinityMat = (myAffinityMat + myAffinityMat') - eye(size(myAffinityMat,1)).*diag(myAffinityMat) ;
%% Code End
end