% ZEROCELL.M
% function cellOut = zerocell(cellsize,matsize)
%	Create cell array (cellsize[1] x cellsize[2] x ...) that contains equal-size
% zero matrices (matsize[1] x matsize[2] x ...).
%

function cellOut = zerocell(cellsize,matsize)

cellOut = cell(cellsize);
cellOut(:) = {zeros(matsize)};

% nCell = prod(cellsize);
% out = cell(cellsize);
% out(1:nCell) = {zeros(matsize)};

%for i = 1:cellsize(1)
%	for k = 1:cellsize(2)
%		out(i,k) = {zeros(matsize)};
%	end;
%end;

