imgA = imread('/Users/bsgiovanini/PDIC/imagens/maraca_1.tif','tif');
imgB = imread('/Users/bsgiovanini/PDIC/imagens/maraca_1.tif','tif');

imgA(:,:,4) = [];
imgB(:,:,4) = [];

%regionGrowing(imgA)

level1 = graythresh(imgA)


[cands, clicado] = correspondingSegments(imgA, imgB, [], [491 329; 55 895], 35);

theSize = size(cands);

for i=1:theSize(2)
    writeFile(strcat('cand',num2str(i)), cands{i});
end

writeFile('clicado', clicado);

%correspondingPoints( imgA, imgB );

%cand = {};
%maiores = {};



%array = [0.5807 0.6409; 0.1189 0.0313];

%for x= 1: 2
%    for y = 1:2
        
%        coeff = array(x,y);
        
        
        %coeff = rand();
%        item = [x y coeff];
        
%        cand{end+1} = item;
        
%    end
%end

%cand{1}
%cand{2}
%cand{3}
%cand{4}

%P = recuperaNMaiores(cand, 3);

%P{1}
%P{2}
%P{3}
