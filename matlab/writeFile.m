function ok = writeFile( nome, matriz )
%WRITEFILE Summary of this function goes here
%   Detailed explanation goes here

fName = nome;         %# A file name
fid = fopen(fName,'w');            %# Open the file
if fid ~= -1                                   
  fclose(fid);                     %# Close the file
end


dlmwrite(fName,matriz,'-append',...  %# Print the matrix
         'delimiter','\t',...
         'newline','pc');

ok = 'ok';
end

