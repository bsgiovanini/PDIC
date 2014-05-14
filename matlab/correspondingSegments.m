function [P, J] = correspondingSegments(img1, img2, initPos1, correspondingCandidatesPos, thresVal, maxDist, tfMean, tfFillHoles, tfSimplify)
% REGIONGROWING Region growing algorithm for 2D/3D grayscale images
%
% Syntax:
%   P = regionGrowing();
%   P = regionGrowing(img1);
%   P = regionGrowing(img1, initPos1)
%   P = regionGrowing(..., thresVal, maxDist, tfMean, tfFillHoles, tfSimpl)
%   [P, J] = regionGrowing(...);
%
% Inputs:
%          img1: 2D/3D grayscale matrix                      {current image}
%      initPos1: Coordinates for initial seed position     {ginput position}
%     thresVal: Absolute threshold level to be included     {5% of max-min}
%      maxDist: Maximum distance to the initial position in [px]      {Inf}
%       tfMean: Updates the initial value to the region mean (slow) {false}
%  tfFillHoles: Fills enclosed holes in the binary mask              {true}
%   tfSimplify: Reduces the number of vertices {true, if dpsimplify exists}
%
% Outputs:
%   P: VxN array (with V number of vertices, N number of dimensions)
%      P is the enclosing polygon for all associated pixel/voxel
%   J: Binary mask (with the same size as the input image) indicating
%      1 (true) for associated pixel/voxel and 0 (false) for outside
%   
% Examples:
%   % 2D Example
%   load example
%   figure, imshow(img1, [0 1500]), hold all
%   poly = regionGrowing(img1, [], 300); % click somewhere inside the lungs
%   plot(poly(:,1), poly(:,2), 'LineWidth', 2)
%   
%   % 3D Example
%   load mri
%   poly = regionGrowing(squeeze(D), [66,55,13], 60, Inf, [], true, false);
%   plot3(poly(:,1), poly(:,2), poly(:,3), 'x', 'LineWidth', 2)
%
% Requirements:
%   TheMathWorks Image Processing Toolbox for bwboundaries() and axes2pix()
%   Optional: Line Simplification by Wolfgang Schwanghart to reduce the 
%             number of polygon vertices (see the MATLAB FileExchange)
%
% Remarks:
%   The queue is not preallocated and the region mean computation is slow.
%   I haven't implemented a preallocation nor a queue counter yet for the
%   sake of clarity, however this would be of course more efficient.
%
% Author:
%   Daniel Kellner, 2011, braggpeaks{}googlemail.com
%   History: v1.00: 2011/08/14


% error checking on input arguments
if nargin > 9
    error('Numero errado de argumentos!')
end

if ~exist('img1', 'var')    
    error('Defina a imagem 1')
end

if ~exist('img2', 'var')    
    error('Defina a imagem 2')
end


if ~exist('initPos1', 'var') || isempty(initPos1)
    himage = findobj('Type', 'image');
    if isempty(himage)
        himage = imshow(img1, []);
    end
    
    % graphical user input for the initial position
    p = ginput(1);
    
    % get the pixel position concerning to the current axes coordinates
    initPos1(1) = round(axes2pix(size(img1, 2), get(himage, 'XData'), p(2)));
    initPos1(2) = round(axes2pix(size(img1, 1), get(himage, 'YData'), p(1)));
end

if ~exist('correspondingCandidatesPos', 'var') || isempty(correspondingCandidatesPos)
    error('Eh necessario existir ao menos um candidato')
    z
end    


regioesCandidatas = [];

%loop para testar os pontos homologos candidatos
for i = 1:size(correspondingCandidatesPos(:, 1))

  candidatePoint = correspondingCandidatesPos(i, :);
  
  % verificar se o ponto ja nao pertence a outra regiao ja crescida
  deveCrescer = true;
  for j = 1:size(regioesCandidatas)
      
      if ismember(candidatePoint, regioesCandidatas{j}, 'rows')
          deveCrescer = false;
      end    
  end
  
  if deveCrescer
      % crescer a regiao candidata (regionGrowing)
      [P, J, M] = regionGrowing(img2, candidatePoint);

      figure;
      imshow(J, 'InitialMagnification', 'fit');  

      % guardar a regiao candidata
      regioesCandidatas{end+1} = M(:,1:2); 
  
  end
    
end

%crescer a regiao da primeira imagem

[P, J, M] = regionGrowing(img1, initPos1);

figure;
imshow(J, 'InitialMagnification', 'fit');  

%identificar qual das regioes candidatas corresponde a primeira imagem.
%Parte trash!!!!!








