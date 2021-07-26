clc
clear all
clf
K = 20
octaves = 3
levels = 5
sigma = 3
k = 1.3
p = 1.8

t = ((2^(1/(levels-2)) - 1)/ (2^(1/3) -1))*0.015

x = load("./dip_hw_3.mat");
mountains  = x.mountains;
roofs = x.roofs;
t = load('lena1626013893.mat');
t = t.M;
k = sqrt(2);
lena = normalize(t,'range');

[spacescales1, DoGs1] = myDoGs(mountains,K,k,sigma,levels,octaves);
[spacescales2,DoGs2] = myDoGs(roofs,K,k,sigma,levels,octaves);
[spacescales5,DoGs5] = myDoGs(lena,K,k,sigma,levels,octaves);
kp1 = myKeypoints(DoGs1);
kp1_size = size(kp1);
kp2 = myKeypoints(DoGs2);
kp2_size = size(kp2);
kp5 = myKeypoints(DoGs5);
kp5_size = size(kp5);
%% plots of Keypoints
figure(1)
for o = 1 : octaves
        for s = 1 : levels-2
            k = size(kp1{o,s});
            q = k(1);
            w = k(2);
            if   q > 0 && w > 0
                subplot(octaves+1,levels,(o-1)*levels +s+levels);
                x = kp1{o,s}(1);
                y = kp1{o,s}(2);
                lower = min(DoGs1{o,s}(:));
                upper = max(DoGs1{o,s}(:)); 
                imshow(DoGs1{o,s},[lower upper]);
                hold on
                plot(x,y,'bx','Markersize', 10, 'LineWidth', 2);
                hold on
            end
        end
end
figure(2)
for o = 1 : octaves
        for s = 1 : levels-2
            k = size(kp2{o,s});
            q = k(1);
            w = k(2);
            if   q > 0 && w > 0
                subplot(octaves+1,levels,(o-1)*levels +s+levels);
                x = kp2{o,s}(1);
                y = kp2{o,s}(2);
                lower = min(DoGs2{o,s}(:));
                upper = max(DoGs2{o,s}(:)); 
                imshow(DoGs2{o,s},[lower upper]);
                hold on
                plot(x,y,'bx','Markersize', 10, 'LineWidth', 2);
                hold on
            end
        end
end
figure(3)
for o = 1 : octaves
        for s = 1 : levels-2
            k = size(kp5{o,s});
            q = k(1);
            w = k(2);
            if   q > 0 && w > 0
                subplot(octaves+1,levels,(o-1)*levels +s+levels);
                x = kp5{o,s}(1);
                y = kp5{o,s}(2);
                lower = min(DoGs5{o,s}(:));
                upper = max(DoGs5{o,s}(:)); 
                imshow(DoGs5{o,s},[lower upper]);
                hold on
                plot(x,y,'bx','Markersize', 10, 'LineWidth', 2);
                hold on
            end
        end
end
%% plots of HighContrastKeypo
kp1HC = discardLowContrasted(DoGs1,kp1,t,p);
kp2HC = discardLowContrasted(DoGs2,kp2,t,p);
kp5HC = discardLowContrasted(DoGs5,kp5,t,p);

figure(4)
for o = 1 : octaves
        for s = 1 : levels-2
            k = size(kp1HC{o,s});
            q = k(1);
            w = k(2);
            if   q > 0 && w > 0
                subplot(octaves+1,levels,(o-1)*levels +s+levels);
                x = kp1HC{o,s}(1);
                y = kp1HC{o,s}(2);
                lower = min(DoGs1{o,s}(:));
                upper = max(DoGs1{o,s}(:)); 
                imshow(DoGs1{o,s},[lower upper]);
                hold on
                plot(x,y,'rx','Markersize', 10, 'LineWidth', 2);
                hold on
            end
        end
end
%figure(5)
%for o = 1 : octaves
%        for s = 1 : levels-2
%            k = size(kp2HC{o,s});
%            q = k(1);
%            w = k(2);
%            if  q > 0 && w > 0
%                subplot(octaves+1,levels,(o-1)*levels +s+levels);
%                x = kp2HC{o,s}(1);
%                y = kp2HC{o,s}(2);
%                lower = min(DoGs2{o,s}(:));%
%                upper = max(DoGs2{o,s}(:)); 
%                imshow(DoGs2{o,s},[lower upper]);
%                hold on
%                plot(x,y,'rx','Markersize', 10, 'LineWidth', 2);
%                hold on
%            end
%        end
%end
figure(6)
for o = 1 : octaves
        for s = 1 : levels-2
            k = size(kp5HC{o,s});
            q = k(1);
            w = k(2);
            if   q > 0 && w > 0
                subplot(octaves+1,levels,(o-1)*levels +s+levels);
                x = kp5HC{o,s}(1);
                y = kp5HC{o,s}(2);
                lower = min(DoGs5{o,s}(:));
                upper = max(DoGs5{o,s}(:)); 
                imshow(DoGs5{o,s},[lower upper]);
                hold on
                plot(x,y,'rx','Markersize', 10, 'LineWidth', 2);
                hold on
            end
        end
end


