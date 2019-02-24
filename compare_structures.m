% COMPARE_STRUCTURES.M
% function [doesmatch,nonmatchFields] = compare_structures(S1,S2)
%	Determine whether two structures, S1 and S2, have matching fields
% (occuring in the same order) with identical values, up to the first level
% of fields.
%

function [doesmatch,nonmatchFields] = compare_structures(S1,S2)

doesmatch = false;
nonmatchFields = {};

if ~isstruct(S1) || ~isstruct(S2)		% catch obvious discrepancies
	disp('One or both arguments are not structures.');
	return;
elseif length(S1)>1 || length(S2)>1
	disp('Structures must be 1x1');
	return;
end;

fNames1 = fieldnames(S1); fNames2 = fieldnames(S2);
fValues1 = struct2cell(S1); fValues2 = struct2cell(S2);

if length(fNames1) ~= length(fNames2)
	disp('Structures do not have the same number of fields.');
	return;
end;
nFields = length(fNames1);

fmatch = true(1,nFields);
for i = 1:nFields
	if ~strcmp(fNames1{i},fNames2{i})
		fmatch(i) = false;
	end;
	if ~isequalwithequalnans(fValues1{i},fValues2{i})
		fmatch(i) = false;
	end;
end;

doesmatch = all(fmatch);
nonmatchFields = fNames1(~fmatch);


