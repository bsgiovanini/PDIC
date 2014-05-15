function [ P ] = carregaPontosHomologosByVetor( initPos, n, img1, img2 )
%CARREGAPONTOSHOMOLOGOSBYVETOR Summary of this function goes here
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
    
    imgDouble = double(img2);
    
    pontosCandidatos = {};
    pontosCandidatos{1} = [];
    pontosCandidatos{2} = [];
    pontosCandidatos{3} = [];
        
    for x= limVarreduraXInf:limVarreduraXSup
        for y= limVarreduraYInf:limVarreduraYSup
            
           matrizSearch = imgDouble(x-n:x+n, y-n:y+n);
           
           quadrante_dif = matrizTemplate - matrizSearch;
           
           norma_quadrante_dif = sqrt(power(quadrante_dif(:, :, 1), 2) + power(quadrante_dif(:, :, 2), 2) + power(quadrante_dif(:, :, 3), 2));
            
           somatorio_norma_quadrante_dif = sum(norma_quadrante_dif);
                      
           for i= 1:3
               if isempty(pontosCandidatos{i}) || pontosCandidatos{i}(3) < somatorio_norma_quadrante_dif 
                   pontosCandidatos{i} = [x y somatorio_norma_quadrante_dif];
                   break;
               end
               
           end    
            
        end
    end
    
    P = pontosCandidatos;


end

