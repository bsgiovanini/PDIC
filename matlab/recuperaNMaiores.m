function [ P ] = recuperaNMaiores( cand, n )
%RECUPERANMAIORES Summary of this function goes here
%   Detailed explanation goes here

    temp = sortrows(cand, -3);
    ordenado = temp(1:n,:)
    
    P = ordenado;
    

end

