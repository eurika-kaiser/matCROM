function filename = plotPDFfigs(fighandle,filename)

print(fighandle,'-dpdf',  [filename]);

% correct filename for specific characters
% spaces
TF = isspace(filename);
idx = find(TF==1);
for i = length(idx):-1:1
    filename = [filename(1:idx(i)-1),'\',filename(idx(i):end)];
end
% colon
%filename = regexprep(filename, ':', '\:');
filename = strrep(filename, ':', '\:'); 
system(['pdfcrop ', [filename], '.pdf ', [filename], '.pdf']);

end