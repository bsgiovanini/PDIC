function [ P ] = correspondingPoints(initPos1, img1, img2 )
%CORRESPONDINGPOINTS Summary of this function goes here
%   Detailed explanation goes here

    
    
    cands = carregaPontosHomologosByPearson(initPos1, 15, img1, img2);
    
    n = 5;
    
    largPxl = 5;
    rgbPxl = [255 255 0];
    
    P = recuperaNMaiores(cands, n);
    
    for i= 1:n
        img2(P(i,1)-largPxl:P(i,1)+largPxl, P(i,2)-largPxl:P(i,2)+largPxl,1) = rgbPxl(1);
        img2(P(i,1)-largPxl:P(i,1)+largPxl, P(i,2)-largPxl:P(i,2)+largPxl,2) = rgbPxl(2);
        img2(P(i,1)-largPxl:P(i,1)+largPxl, P(i,2)-largPxl:P(i,2)+largPxl,3) = rgbPxl(3);
    end
    
    figure;
    
    imshow(img2, 'InitialMagnification', 'fit');     

end

