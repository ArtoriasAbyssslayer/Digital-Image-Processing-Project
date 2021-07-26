function xrgb = bayer2rgb(obstaclefilename)
%BAYER2RGB Returns the RGB image from a Bayer formated caputred by CCD
%%Create the Kernels

%% load matrix
xb = load(obstaclefilename)
%% mask xb matrix based on bayer format
G_mask = [1 0 1;0 1 0;1 0 1];
B_mask = [0 1 0;0 0 0;0 1 0];
R_mask = [0 0 0;1 0 1;0 0 0];
%% masked Image 
% m = image rows
% n = image columns
[m,n] = size(xb.x);
R_ones = zeros(m,n);
B_ones = zeros(m,n);
G_ones = zeros(m,n);
for i = 1:m
    for j = 1:n
        if mod(i,2) == 0
            if mod(j,2) == 1
                R_ones(i,j) = 1;
            end
        end
    end
end
for i = 1:m
    for  j = 1:n
        if mod(i,2) == 1
            if mod(j,2) == 0
                B_ones(i,j) = 1;
            end
        end
    end
end

for i = 1:m
    for j = 1:n
        if mod(i,2) == 1
            if mod(j,2)==1
                G_ones(i,j) = 1;
            end
        else
            if mod(j,2) == 0
                G_ones(i,j) = 1;
            end
        end
    end
end
%G_mask_padded = padarray(G_mask,[m/2-1 n/2-1],'both','symmetric');
% B_mask_padded = padarray(B_mask,[m/2-1 n/2-1],'both','symmetric');
% R_mask_padded = padarray(R_mask,[m/2-1 n/2-1],'both','symmetric');
%G_mask_padded(:,1) = [];
%G_mask_padded(1,:) = [];
% B_mask_padded(:,1) = [];
% B_mask_padded(m,:) = [];
% R_mask_padded(:,1) = [];
% R_mask_padded(m,:) = [];
RCplane = R_ones.*xb.x;
GCplane = G_ones.*xb.x;
BCplane = B_ones.*xb.x;
%% Convolution Kernels
disp('Convolution Kernels for bilinear intrepolating of each color plane:');
% I declare the kernels this sway so i get the averaging for the center
% pixel based on bayer standard
Kr = 1/4.*[1 2 1;2 4 2;1 2 1]
Kb = Kr
Kg = 1/4.*[0 1 0; 1 4 1; 0 1 0]

%% Convolution Kernel-MaskedImage
G_conv = zeros(m,n); %% G_conv =  Green Color of the image after convolutionI
R_conv = zeros(m,n); %% R_conv =  Red Color of the image after convolution
B_conv = zeros(m,n); %% B_conv =  Blue Color of the image after convolution

% This algorithm is explained in the report
% It makes the convolution partialy of each 3x3 portion of the image with
% the kernel and we take the averaging factor of each matrix produced(C_temp_conv). In
% most of the cases it is the center point but in the edges we take in most
% cases the middle of the 2 edges pixel and in the 4 edges (of each color Plane) case we take the
% edges of the produced temp matrix. 
for i = 1:m-2
    for j = 1:n-2
        G_temp_conv = conv2(GCplane(i:i+2,j:j+2),Kg,'same');
        R_temp_conv = conv2(RCplane(i:i+2,j:j+2),Kr,'same');
        B_temp_conv = conv2(BCplane(i:i+2,j:j+2),Kb,'same');
        if i >= 2 && j >= 2
                G_conv(i,j) = G_temp_conv(2,2);
                R_conv(i,j) = R_temp_conv(2,2);
                B_conv(i,j) = B_temp_conv(2,2);
        end
        
        if i < 2 && j < 2
                G_conv(i,j) = G_temp_conv(1,1);
                R_conv(i,j) = R_temp_conv(1,1);
                B_conv(i,j) = B_temp_conv(1,1);
        elseif i == 1 && j >= 2
                G_conv(i,j) = G_temp_conv(1,2);
                R_conv(i,j) = R_temp_conv(1,2);
                B_conv(i,j) = B_temp_conv(1,2);
        elseif i>=2 && j == 1
                G_conv(i,j) = G_temp_conv(2,1);
                R_conv(i,j) = R_temp_conv(2,1);
                B_conv(i,j) = B_temp_conv(2,1);               
        end
            
    end
end
for i = m-2 : m
    for j = n-2 : n
        G_temp_conv = conv2(GCplane(m-2:m,n-2:n),Kg,'same');
        R_temp_conv = conv2(RCplane(m-2:m,n-2:n),Kr,'same');
        B_temp_conv = conv2(BCplane(m-2:m,n-2:n),Kb,'same');
        if i == m
            if j == n
                G_conv(i,j) = G_temp_conv(3,3);
                R_conv(i,j) = R_temp_conv(3,3);
                B_conv(i,j) = B_temp_conv(3,3);
            end
        elseif i == m-2 && j == n - 2
                G_conv(i,j) = G_temp_conv(2,2);
                R_conv(i,j) = R_temp_conv(2,2);
                B_conv(i,j) = B_temp_conv(2,2);
        elseif  i >= m -2 && j == n
                G_conv(i,j) = G_temp_conv(2,3);
                R_conv(i,j) = R_temp_conv(2,3);
                B_conv(i,j) = B_temp_conv(2,3);
        else
                G_conv(i,j) = G_temp_conv(3,2);
                R_conv(i,j) = R_temp_conv(3,2);
                B_conv(i,j) = B_temp_conv(3,2);
        end
            
    end
end


%% Return the image
xrgb(:,:,1) = R_conv;
xrgb(:,:,2) = G_conv;
xrgb(:,:,3) = B_conv;
end

