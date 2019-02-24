% GETCLOSEST.M
% function idx = getclosest(actual,desired)
%	Function to find the closest element of one vector
% to the elements of another vector. 'actual' is the original data,
% in vector form. 'desired' is the point or set of points (vector
% or scalar) to test against 'actual'. The output 'idx' is the index
% of 'actual' elements that lie closest to each 'desired'
% element; it is the same size as 'desired'.
%	If two desired points are equally close, the first will
% be chosen (as in the MIN function).
%	e.g.
%		actual = [0 10 20 30 40 50];
%		desired = [-2 0 9 11 20 21 26 165];
%		idx = getclosest(actual,desired);
%
%	idx = [  1     1     2     2     3     3     4     6  ];
%

function idx = getclosest(actual,desired)

idx = zeros(size(desired));
if isempty(actual)
	idx = [];
	return;
end;
for i = 1:length(desired)
	[val,idx(i)] = min(abs(actual-desired(i)));
end;