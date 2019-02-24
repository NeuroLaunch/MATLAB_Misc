% AUGMATRIX.M
% function MatrixOut = augmatrix(MatrixIn,nextra)
%	Extend a square matrix of column vectors in 'MatrixIn' by 2 x 'nextra'.
% The original vectors are assumed to be predictable in structure
% and have a local maximum or minimum near the diagonal element
% (e.g. for cochlear implant EFI waveforms). The added data points will
% be determined by either mirroring the data around the diagonal
% element of the vector, or by linear interpolation.
%	'MatrixIn' must be square and have at least 7 rows, and 'nextra'
% can't be more than half the number of rows.
%

function MatrixOut = augmatrix(MatrixIn,nextra)

[nRow,nCol] = size(MatrixIn);

if ndims(MatrixIn) > 2
	error('Input matrix has too many dimensions.');
elseif nRow ~= nCol
	error('Input matrix must be square.');		% #SMB:2015.08.05
elseif nRow < 7
	error('The number of rows of the input matrix is too small.');
elseif mod(nextra,1) ~= 0
	error('The number of augmented rows, ''nextra'', must be an integer.');
elseif nextra > nRow/2
	error('The number of augmented rows, ''nextra'', is too large.');
elseif nextra < 1
	error('The number of augmented rows, ''nextra'', must be at least one.');
end;

MatrixOut = nan(nRow + nextra*2, nCol);

for i = 1:nCol
	origvec = MatrixIn(:,i);

	if i < 4
		a = i + i; b = a + (nextra - 1);
		avec = origvec(b:-1:a);
	else
% 		pp = polyfit(1:i-1,origvec(1:i-1)',1);
		pp = polyfit(1:3,origvec(1:3)',1);
		avec = polyval(pp,-(nextra-1):0)';
	end;

	if i > nRow - 3
		b = i - (nRow - i) - 1; a = b - (nextra - 1);
		bvec = origvec(b:-1:a);
	else
% 		pp = polyfit(i+1:nRow,origvec(i+1:nRow)',1);
		pp = polyfit(nRow-2:nRow,origvec(nRow-2:nRow)',1);
		bvec = polyval(pp,nRow+1:nRow+nextra)';
	end;

	MatrixOut(:,i) = cat(1,avec,origvec,bvec);
end;
