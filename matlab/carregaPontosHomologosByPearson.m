function [ P ] = carregaPontosHomologosByPearson( initPos, n, img1, img2 )
%PONTOSHOMOLOGOSBYPEARSON Summary of this function goes here
%   Detailed explanation goes here


    % carrega matriz template n+1+n por n+1+n com o initPos central
    limInfx = initPos(1) - n;
    limSupx = initPos(1) + n;
    limInfy = initPos(2) - n;
    limSupy = initPos(2) + n;
    
    
    matrizTemplateR = double(img1(limInfx: limSupx , limInfy: limSupy, 1));
    matrizTemplateG = double(img1(limInfx: limSupx , limInfy: limSupy, 2));
    matrizTemplateB = double(img1(limInfx: limSupx , limInfy: limSupy, 3));
    
    
    
    %varrer a imagem de busca para obter a correlacao
    
    limVarreduraXSup = size(img2(:, 1, 1));
    limVarreduraYSup = size(img2(1, :, 1));
    
    
    limVarreduraXInf = 1+n;
    limVarreduraXSup = limVarreduraXSup(1) - n;
    limVarreduraYInf = 1+n;
    limVarreduraYSup = limVarreduraYSup(2) - n;
    
    numPontos = (limVarreduraYSup-limVarreduraYInf)*(limVarreduraXSup-limVarreduraXInf);   
    
    imgDouble = double(img2);
    
    pontosCandidatos = zeros(numPontos, 3);
    
    i = 0;
        
    for x= limVarreduraXInf:limVarreduraXSup
        
        for y= limVarreduraYInf:limVarreduraYSup
            
           i= i+1; 
           
           matrizSearchR = imgDouble(x-n:x+n, y-n:y+n, 1);
           matrizSearchG = imgDouble(x-n:x+n, y-n:y+n, 2);
           matrizSearchB = imgDouble(x-n:x+n, y-n:y+n, 3);
          
           CR= cov(matrizTemplateR,matrizSearchR);
           CG= cov(matrizTemplateG,matrizSearchG);
           CB= cov(matrizTemplateB,matrizSearchB);
           
           coeffR = 0.0;
           coeffG = 0.0;
           coeffB = 0.0;
           
           if CR(1,1) ~= 0.0 && CR(2,2) ~= 0.0
               coeffR = CR(1,2) / sqrt(CR(1,1) * CR(2,2));
           end
           if CG(1,1) ~= 0.0 && CG(2,2) ~= 0.0
               coeffG = CG(1,2) / sqrt(CG(1,1) * CG(2,2));
           end
           if CB(1,1) ~= 0.0 && CB(2,2) ~= 0.0
               coeffB = CB(1,2) / sqrt(CB(1,1) * CB(2,2));
           end
           
           coeff = (coeffR + coeffG + coeffB) / 3; 
           
           pontosCandidatos(i,1) = x;
           pontosCandidatos(i,2) = y;
           pontosCandidatos(i,3) = coeff;
                             
            
        end
    end
    
    P = pontosCandidatos;

end

