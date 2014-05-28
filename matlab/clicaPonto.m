function [ P ] = clicaPonto( img1 )
%CLICAPONTO Summary of this function goes here
%   Detailed explanation goes here


himage = imshow(img1, []);    
    
% graphical user input for the initial position
p = ginput(1);
    
% get the pixel position concerning to the current axes coordinates
initPos1 = zeros(2);
initPos1(1) = round(axes2pix(size(img1, 2), get(himage, 'XData'), p(2)));
initPos1(2) = round(axes2pix(size(img1, 1), get(himage, 'YData'), p(1)));

P = initPos1;

end

