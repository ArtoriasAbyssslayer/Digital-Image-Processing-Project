function keypoints = myKeypoints(DoGs)
%% myKeypoints Function Summary
%  Input : Cell array with dimensions 1*octaves.Each element of the cell
%       array is a 3D-Matrix with dimentions Ni*Mi*(levels-1)
%  Output : A list of traced keypoints length V. Each of the elements of V
%  vector is a tuple (o,s,m,n) wher o and s the octave and the spacescale
%  in which the keypoint belongs and m,n the coordinates of it.
%%  Important Note : I need each point that I check for beeing salient point candidate
%                    to have 9 neighbors from the next DoG(downsampled DoG) and the 9
%                    neighbors form the previous DoG that has more samples
%                    (half and twice the dimension to be specific).
%% The function Utilizes the function DoG_extrema I made which takes as input 3 matrices the upper level matrix the lower level matrix and the current level matrix and finds if the current matrix has the extrema in its center
% basically it does all the compares between current pixel and its 26
% neighbours in its level and if it is local minima | local maxima it
% returns it
%
%% Algorithm Begin
%Retrieve size data from the DoGs cell array 
[octaves,scales] = size(DoGs);
scaleSizes = cell(octaves,scales);
for i=1:octaves
   for j=1:scales
        scaleSizes{i,j} = size(DoGs{i,j});
   end
end
%% Abstract explanation
% We have n scales and in the DoG space n = n-1 ---> So (n-1)-2 = n-3 DoGs
% with keypoints as 1st and last DoG scales  in each octave do not have
% sufficient neigbors to be checked with extrema algorithm
% DoGs of Scales or levels 2,3,4 correspond to DoG_Keyponints of scales 1,2
keypoints = cell(octaves,scales-2,1,1);
for i=1:octaves
    for j=2:scales-1
        for n = 2:scaleSizes{i,j}(1)-1
            for m = 2:scaleSizes{i,j}(2)-1
                %if DoG_extrema(DoGs{i,j-1}, DoGs{i,j}, DoGs{i,j+1}) == 1 
                if  DoG_extrema(DoGs{i,j-1}(n-1:n+1,m-1:m+1), DoGs{i,j}(n-1:n+1,m-1:m+1), DoGs{i,j+1}(n-1:n+1,m-1:m+1)) == 1
                    keypoints{i,j} = [n m];
                end
            end
        end
       
    end
end
end

