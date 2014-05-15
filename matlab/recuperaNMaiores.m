function [ P ] = recuperaNMaiores( cand, n )
%RECUPERANMAIORES Summary of this function goes here
%   Detailed explanation goes here

    maiores = {};

    tamanho = size(cand);
    
    tamanho(2)

    for k=1:n
        maior = 0;
        itemMaior = [];
        indice = 0;
        for i=1:tamanho(2)
            if (~isempty(cand{i}) && cand{i}(3) > maior) 
                maior = cand{i}(3);
                itemMaior = cand{i};
                indice = i;
            end

        end

        maiores{end+1} = [itemMaior(1) itemMaior(2) itemMaior(3)];
        cand{indice} = [];

    end
    
    P = maiores;


end

