% STRUCT2ARRAY.M
% function ArrayOut = struct2array(structIn,fieldname);
%	For vector or scalar fields only. 'ArrayOut' is of size
% #structure elements x size of field.
%

function ArrayOut = struct2array(structIn,fieldname);



nIn = length(structIn);

if nargin < 2
	disp(structIn);
	fieldname = input('Which field name? ','s');
end;

status = 1; i = 1;
while status				% first, check validity of the field
	temp = getfield(structIn(i),fieldname);
	if ~isempty(temp) status = 0; end;
	i = i + 1;
	if i > nIn status = 0; end;
end;
lgth = length(temp);
if size(temp,1)*size(temp,2) ~= lgth
	error('All fields must contain vector or scalar values only.');
end;

ArrayOut = zeros(nIn,lgth);	% then actually get the field's values
for i = 1:nIn
	temp = getfield(structIn(i),fieldname);
	if ~isempty(temp)
		ArrayOut(i,:) = temp;
	else
		ArrayOut(i,:) = inf * ones(1,lgth);
	end;
end;