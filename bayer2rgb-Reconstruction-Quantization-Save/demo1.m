clear all
clc

RGB = bayer2rgb('march.mat');
imshow(RGB);
imwrite(RGB,'march.png');