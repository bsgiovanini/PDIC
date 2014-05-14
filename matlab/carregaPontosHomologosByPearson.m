function [ P ] = carregaPontosHomologosByPearson( initPos, n, img1, img2 )
%PONTOSHOMOLOGOSBYPEARSON Summary of this function goes here
%   Detailed explanation goes here


    % carrega matriz template n+1+n por n+1+n com o initPos central
    limInfx = initPos(1) - n;
    limSupx = initPos(1) + n;
    limInfy = initPos(2) - n;
    limSupy = initPos(2) + n;
    
    matrizTemplate = double(img1(limInfx: limSupx , limInfy: limSupy));
    
    %varrer a imagem de busca para obter a correlacao
    
    limVarreduraXSup = size(img2(:, 1));
    limVarreduraYSup = size(img2(1, :));
    
    
    limVarreduraXInf = 1+n;
    limVarreduraXSup = limVarreduraXSup(1) - n;
    limVarreduraYInf = 1+n;
    limVarreduraYSup = limVarreduraYSup(2) - n;
    
    imgT = img2;
        
    for x= limVarreduraXInf:limVarreduraXSup
        for y= limVarreduraYInf:limVarreduraYSup
            
           matrizSearch = double(img2(x-n:x+n, y-n:y+n));
           
           C= cov(matrizTemplate,matrizSearch);
           
           std(matrizTemplate)
           
           coef= C/(std(matrizTemplate)*std(matrizSearch))
            
          
            
        end
    end
    
    imshow(imgT, []);
    
    P = matrizTemplate;

end

