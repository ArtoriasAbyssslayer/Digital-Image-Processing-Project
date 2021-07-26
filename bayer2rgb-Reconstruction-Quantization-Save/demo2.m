clc
clear all
xrgb = bayer2rgb('march.mat');
xrgbres1 = myresize(xrgb,240,320,'nearest');
xrgbres2 = myresize(xrgb,200,300,'linear');
figure(1)
imshow(xrgbres1);
figure(2)
imshow(xrgbres2);
figure(3)
xrgbres3 = imresize(xrgb,[200 300],'bilinear');
imshow(xrgbres3);