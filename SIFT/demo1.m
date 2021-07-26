clear all
clc
clf
clear figures
sigma  = sqrt(2);
K = 7;

levels = 5;
octaves = 3;
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

%%plot
%% Space Scales pre Octave
figure1 = figure('Name',"Mountains SpaceScales for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
subplot(octaves+1,levels,1);
imshow(mountains);
title("Original Image");
for i = 1 : octaves
    for j = 1 : levels
        subplot(octaves+1,levels,(i-1)*levels +j+levels);
        title("Octave:"+i+" layer:"+j);     
        img_subplot =spacescales1{i,j};
        imshow(img_subplot, [0 1]);
    end
end
        
figure2 = figure('Name',"Roofs SpaceScales for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
subplot(octaves+1,levels,1);
imshow(roofs);
title("Original Image");
for i = 1 : octaves
    for j = 1 : levels
        subplot(octaves+1,levels,(i-1)*levels +j+levels);
        title("Octave "+i+ "layer :" + j);     
        img_subplot =spacescales2{i,j};
        imshow(img_subplot, [0 1]);
    end
end
figure5 = figure('Name',"Lena SpaceScales for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
subplot(octaves+1,levels,1);
imshow(lena);
title("Original Image");
for i = 1 : octaves
    for j = 1 : levels
         subplot(octaves+1,levels,(i-1)*levels +j+levels);
        title("Octave "+i+ "layer :" + j);     
        img_subplot =spacescales5{i,j};
        imshow(img_subplot, [0 1]);
    end
end

figure3 = figure('Name',"Mountains DoGs for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
for i = 1 : octaves
    for j = 1 : levels-1
        subplot(octaves,levels,(i-1)*levels +j);
        title("Octave "+i+ "layer :" + j);     
        %% Feauter scaling atempt in lines 59-61
        %Dm = mean(DoGs1{i,j});
        %Dstd = std(DoGs1{i,j});
        %DoGs1{i,j} = (DoGs1{i,j} - Dm)./Dstd; 
        %% Normalize attempt in lines 63 64
        %img_subplot =DoGs1{i,j};
        %img_subplot = (img_subplot - min(img_subplot(:)))./(max(img_subplot(:))-min(img_subplot(:)));
        %% What i really used
        lower = min(DoGs1{i,j}(:));
        upper = max(DoGs1{i,j}(:)); 
        imshow(DoGs1{i,j},[lower upper]);
    end
end
figure6 = figure('Name',"Lena DoGs for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
for i = 1 : octaves
    for j = 1 : levels-1
        subplot(octaves,levels,(i-1)*levels +j);
        title("Octave "+i+ "layer :" + j);     
        %% Feauter scaling atempt in lines 59-61
        %Dm = mean(DoGs1{i,j});
        %Dstd = std(DoGs1{i,j});
        %DoGs1{i,j} = (DoGs1{i,j} - Dm)./Dstd; 
        %% Normalize attempt in lines 63 64
        %img_subplot =DoGs1{i,j};
        %img_subplot = (img_subplot - min(img_subplot(:)))./(max(img_subplot(:))-min(img_subplot(:)));
        %% What i really used
        lower = min(DoGs5{i,j}(:));
        upper = max(DoGs5{i,j}(:)); 
        imshow(DoGs5{i,j},[lower upper]);
    end
end
figure4 = figure('Name',"Roofs DoGs for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
title("DoGs")
for i = 1 : octaves
    for j = 1 : levels-1
        subplot(octaves,levels,(i-1)*levels +j);
        title("Octave "+i+ "layer :" + j);     
        %% Feauter scaling atempt in lines 59-61
        %Dm = mean(DoGs1{i,j});
        %Dstd = std(DoGs1{i,j});
        %DoGs1{i,j} = (DoGs1{i,j} - Dm)./Dstd; 
        %% Normalize attempt in lines 63 64
        %img_subplot =DoGs1{i,j};
        %img_subplot = (img_subplot - min(img_subplot(:)))./(max(img_subplot(:))-min(img_subplot(:)));
        %% What i really used
        lower = min(DoGs2{i,j}(:));
        upper = max(DoGs2{i,j}(:)); 
        imshow(DoGs2{i,j},[lower upper]);
    end
end
levels = levels - 2;
octaves = octaves + 4;
[spacescales3,DoGs3] = myDoGs(mountains,K,k,sigma,levels,octaves);
[spacescales4,DoGs4] = myDoGs(roofs,K,k,sigma,levels,octaves);
[spacescales6,DoGs6] = myDoGs(lena,K,k,sigma,levels,octaves);
figure7 = figure('Name',"Mountains SpaceScales for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
subplot(octaves+1,levels,1);
imshow(mountains);
title("Original Image");
for i = 1 : octaves
    for j = 1 : levels
         subplot(octaves+1,levels,(i-1)*levels +j+levels);
        title("Octave "+i+ "layer :" + j);     
        img_subplot =spacescales3{i,j};
        imshow(img_subplot, [0 1]);
    end
end
figure8 = figure('Name',"Roofs SpaceScales for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
title('spacescales 4');
subplot(octaves+1,levels,1);
imshow(roofs);
title("Original Image");
for i = 1 : octaves
    for j = 1 : levels
         subplot(octaves+1,levels,(i-1)*levels +j+levels);
        title("Octave "+i+ "layer :" + j);     
        img_subplot =spacescales4{i,j};
        imshow(img_subplot, [0 1]);
    end
end 
figure9 = figure('Name',"Lena SpaceScales for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
title('spacescales 4');
subplot(octaves+1,levels,1);
imshow(lena);
title("Original Image");
for i = 1 : octaves
    for j = 1 : levels
         subplot(octaves+1,levels,(i-1)*levels +j+levels);
        title("Octave "+i+ "layer :" + j);     
        img_subplot =spacescales6{i,j};
        imshow(img_subplot, [0 1]);
    end
end 
figure10 = figure('Name',"Mountain DoGs for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
for i = 1 : octaves
    for j = 1 : levels-1
        subplot(octaves,levels,(i-1)*levels +j);
        title("Octave "+i+" layer: "+j);     
        %% Feauter scaling atempt in lines 59-61
        %Dm = mean(DoGs1{i,j});
        %Dstd = std(DoGs1{i,j});
        %DoGs1{i,j} = (DoGs1{i,j} - Dm)./Dstd; 
        %% Normalize attempt in lines 63 64
        %img_subplot =DoGs1{i,j};
        %img_subplot = (img_subplot - min(img_subplot(:)))./(max(img_subplot(:))-min(img_subplot(:)));
        %% What i really used
        lower = min(DoGs3{i,j}(:));
        upper = max(DoGs3{i,j}(:)); 
        imshow(DoGs3{i,j},[lower upper]);
    end
end

figure11 = figure('Name',"Roofs DoGs for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
for i = 1 : octaves
    for j = 1 : levels-1
        subplot(octaves,levels,(i-1)*levels +j);
        title("Octave "+i+ "layer :" + j);     
        %% Feauter scaling atempt in lines 59-61
        %Dm = mean(DoGs1{i,j});
        %Dstd = std(DoGs1{i,j});
        %DoGs1{i,j} = (DoGs1{i,j} - Dm)./Dstd; 
        %% Normalize attempt in lines 63 64
        %img_subplot =DoGs1{i,j};
        %img_subplot = (img_subplot - min(img_subplot(:)))./(max(img_subplot(:))-min(img_subplot(:)));
        %% What i really used
        lower = min(DoGs4{i,j}(:));
        upper = max(DoGs4{i,j}(:)); 
        imshow(DoGs4{i,j},[lower upper]);
    end
end
figure12 = figure('Name',"Lena DoGs for "+octaves+" Ocatves and "+levels+" levels.","NumberTitle",'on');
for i = 1 : octaves
    for j = 1 : levels-1
        subplot(octaves,levels,(i-1)*levels +j);
        title("Octave "+i+ "layer :" + j);     
        %% Feauter scaling atempt in lines 59-61
        %Dm = mean(DoGs1{i,j});
        %Dstd = std(DoGs1{i,j});
        %DoGs1{i,j} = (DoGs1{i,j} - Dm)./Dstd; 
        %% Normalize attempt in lines 63 64
        %img_subplot =DoGs1{i,j};
        %img_subplot = (img_subplot - min(img_subplot(:)))./(max(img_subplot(:))-min(img_subplot(:)));
        %% What i really used
        lower = min(DoGs6{i,j}(:));
        upper = max(DoGs6{i,j}(:)); 
        imshow(DoGs6{i,j},[lower upper]);
    end
end


