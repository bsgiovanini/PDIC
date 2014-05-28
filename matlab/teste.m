imgA = imread('/Users/bsgiovanini/PDIC/imagens/cagarras_01.png','png');
imgB = imread('/Users/bsgiovanini/PDIC/imagens/cagarras_02.png','png');


img1 = imread('/Users/bsgiovanini/PDIC/imagens/1997_017_300dpi.bmp','bmp');

initPos1 = clicaPonto(imgA)

ptCands = correspondingPoints(initPos1, imgA, imgB);

grayImg = rgb2gray(imgB);

level = graythresh(grayImg)*100;

[cands, clicado] = correspondingSegments(imgA, imgB, initPos1, ptCands(:,1:2), 33);



%imgA(:,:,4) = [];
%imgB(:,:,4) = [];

%%regionGrowing(imgA)

%level1 = graythresh(imgA)


%%[cands, clicado] = correspondingSegments(imgA, imgB, [778 708], [596 938; 554 167], 25);

%%[cands, clicado] = correspondingSegments(imgA, imgB, [190 585], [628 343; 166 463], 33);


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
