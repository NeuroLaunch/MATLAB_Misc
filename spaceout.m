% SPACEOUT.M
% function outvec = spaceout(invec,space,limits)
%	Expand a vector of integers (such as representing an index)
% forward and backwards by integer 'space'. This function is useful
% for defining a "buffer zone" around specific points (e.g. for removing
% spikes from a time trace, where 'invec' specifies the spike times
% and 'outvec' gives the entire set of points to remove.) Use 'limits'
% to specify the expected size of 'invec' (e.g. [1 120] for a 120-length
% vector), to reject points in 'outvec' that are out-of-bounds.
%	'space' can be scalar, in which case the augmentation is symmetric.
% It can also be a two-entry non-negative vector, specifying the forward
% and backward spacing values. (Negative values are set to zero.) If 'space'
% is empty or zero then 'outvec' is identical to 'invec'.
%
%	e.g.	invec = [34 35 36 90]     space = 2
%			outvec = [32 33 34 35 36 37 38 88 89 90 91 92]
%
% REVISIONS
%	May 2012: 'invec' can now be a logical vector. 'outvec' will be the
% same size, such that any supplied 'limits' argument will be overridden.
%
%	e.g.	invec = [0 0 1 1 0 0 0 1]     space = 1
%			outvec = [0 1 1 1 1 0 1 1]
%


function outvec = spaceout(invec,space,limits)

% Some preliminaries %
if ndims(invec)>2, error('Input data must be a row or column vector'); end;

if islogical(invec)
	inveclog = invec;
	invec = find(invec);
	islog = true;
else
	islog = false;
end;

[N,M] = size(invec);

if isempty(space) || isempty(invec)
	if islog, outvec = inveclog;
	else outvec = invec;
	end;
	return;						% trivial result if no spacing or no data
end;

if any(mod(space,1)) || numel(space)>2
	error('The ''space'' argument must be one or two integers.');
end;

if length(space)==1				% parse the 'space' argument
	nspace = space; pspace = space;
else
	nspace = space(1); pspace = space(2);
end;							% negative values are set to zero
nspace = max(0,nspace); pspace = max(0,pspace);

spacevec = -nspace:pspace;		% to be used for the input augmentation

if islog						% if logical, size of 'outvec' = size of 'invec' ..
	nlim = 1; plim = length(inveclog);
elseif nargin < 3				% .. otherwise specify limits of 'outvec' values
	nlim = -inf; plim = inf;
else	
	nlim = limits(1); plim = limits(2);
end;

if N==1							% force input to be a column vector
	invec = invec';
	[N,M] = size(invec);
	transp = true;				% keep track of whether input gets transposed
else
	transp = false;
end;

% Create the enlarged output vector %
augmat = repmat(invec,1,length(spacevec));	% create repeating columns
spacemat = repmat(spacevec,N,1);
augmat = augmat + spacemat;					% add points to left and right of 'invec'

outvec = unique(augmat);					% remove redundant points

if transp						% revert to original dimensions
	outvec = outvec';
end;

outvec = outvec(outvec>=nlim);	% apply upper and lower limits
outvec = outvec(outvec<=plim);

if islog						% revert to logical, if appropriate
	temp = zeros(size(inveclog));
	temp(outvec) = true;
	outvec = temp;
end;
