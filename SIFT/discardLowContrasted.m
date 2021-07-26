function keypointsHighC = discardLowContrasted(DoGs,keypoints,t,p)
% t is the contrast threshold 
% p is the 
DoGSize = size(DoGs);


%num_keypoints = size(find(keypoints));
    for o = 1 : DoGSize(1)
        for s = 1 : DoGSize(2)-1
            k = size(keypoints{o,s});
            if  k > 0
                x = keypoints{o,s}(1);
                y = keypoints{o,s}(2);
                if DoGs{o,s}(x,y) <= p*t
                    keypoints{o,s} =0; 
                end
            end
        end
    end
keypointsHighC = keypoints;
end