function saveasppm(x, filename, K)
fileID = fopen(filename,'w');
[m,n,k] = size(x);
fprintf(fileID,"P6 %d %d %d\n", n, m ,K);
for i = 1: m
    for j = 1:n
        for t = 1:k
            fwrite(fileID,(K-1)*x(i,j,1),'uint8');
            fwrite(fileID,(K-1)*x(i,j,2),'uint8');
            fwrite(fileID,(K-1)*x(i,j,3),'uint8');
        end
            
    end

end
fclose(fileID);

end