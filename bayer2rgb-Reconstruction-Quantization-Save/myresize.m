function xrgbres = myresize(xrgb,N,M,method)
[n,m,~] = size(xrgb);
scale1 = n/N;
scale2 = m/M;
%% Nearest Neighbor resampling/downsampling method
% In nearest Neighbor reshampling and especially downscaling method we have
% to take regions 2x2 of the image or larger which consist of 4 pixels or
% more and make them 1 pixel this means we take the 1/4 of the original
% size or less. If the problem was only about the 1/4 of the original image
% we could the mask H_NN as it is declared in comment below. Multiply it
% with parts of the image and take the 1 average of all 4 pixels to 1 pixel
% and store it to the new Image. Now where the scale we want to rescale it
% is not constant we can just apply this scale to the sampling of the image
% when we store it to xrgbres => xrgbres = RGB(scale1*i,scale2*j,:).
if strcmp(method,'nearest') 
    [n,m,~] = size(xrgb);
    %H_NN = [1 1; 1 1]; mask for f = 1/4
    for i = 1:N
        for j = 1:M
            for k = 1:3
            xrgbres(i,j,k) = xrgb(i*scale1,j*scale2,k);
            end
        end
    end
end
%% Billinear Interpolation method 
if strcmp(method,'linear')
    
    for i=1:M
        for j=1:N
            for k = 1:3
            xrgbres(1+(i-1)*ceil(scale1),1+(j-1)*floor(scale2),k)=xrgb(i,j,k); 
            end
        end
        
    end
    for i=1:1+(N-2)    %row number
        for j=1:1+(M-2) %column number
            for k = 1 : 3
                if ((rem(i-1,scale1)==0) && (rem(j-1,scale2)==0)) %mapped values from original picture should not be recalculated
                    continue
                else  
%                     f00=xrgb( ceil(i/scale1)*ceil(scale2-scale1+1),ceil(j/scale2)*ceil(scale2-scale1+1),k); 
%                     f10=xrgb( ceil(i/scale1)*ceil(scale2-scale1+1+scale1),ceil(j/scale2)*ceil(scale2-scale1+1),k);
%                     f01=xrgb( ceil(i/scale1)*ceil(scale2-scale1+1),floor(j/scale2)*ceil(scale2) + floor(scale2-scale1+1),k);
%                     f11 = xrgb(ceil(i/scale1)*ceil(scale1)+ceil(-scale1+1+scale2),(ceil(j/scale2)*floor(scale2))+floor(scale2-scale1+1),k);
                    f00 =xrgb(ceil(j/scale2),ceil(i/scale1),k);
                    f10 =xrgb(ceil(j/scale2),ceil(i/scale1),k);
                    f01 =xrgb(ceil(j/scale2),ceil(i/scale1),k);
                    f11 =xrgb(ceil(j/scale2),ceil(i/scale1),k);
                    x=rem(j-1,scale2); %coordinates of calculating pixel.
                    y=rem(i-1,scale1);  
          
                    dx=x/scale2; %localizeing the  pixel being calculated to the nearest four know pixels.
                    dy=y/scale1;
          
                    b1=f00;    %constants of bilinear interpolation.
                    b2=f10-f00;
                    b3=f01-f00;
                    b4=f00-f10-f01+f11;           
                    xrgbres(i,j,k)=b1+b2*dx+b3*dy+b4*dx*dy; %equation of bilinear interpolation.
                end
            end
        end
    end
end