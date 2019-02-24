% GETSTD.M
% function [stdout,meanout,keepind] = getstd(data,block,space)
%	Get standard deviation. 'data' is in columns. The array
% 'block' represents the points (in rows of sweep # and
% sample #) to reject. 'space' is the # of points
% on either side of the block points to also reject.
%	'block' can be a positive scalar, representing the
% absolute threshold below which points in data are used
% for the STD estimate. 'space' in this case defines
% additional points on either side of points above
% the absolute threshold to also disclude.
%
%	Revised 09/30/2009: There is now an additional output,
% 'meanout', that gives the MEAN of the restricted points.
%	Revised 06/01/2010: Yet another output, 'keepind', keeps
% track of the points in 'data' that are ultimately used to
% calculate the STD. It is an indicator array of the same
% size as 'data'.
%	Revised 12/27/2010: The "spacing" routines now invoke
% the function SPACEOUT.
%

function [stdout,meanout,keepind] = getstd(data,block,space)

[N,M] = size(data);

if nargin < 3, space = 0;
elseif isempty(space), space = 0;
end;
% spacevec = [-space:space];		% vector of spaces (may be empty)

% 1) No threshold info %
if isempty(block)
	newdata = reshape(data,M*N,1);
	keepidx = 1:M*N;

% 2) Hard threshold %
elseif length(block)==1						% 'block' = hard threshold
	data = reshape(data,M*N,1);				% put all sweeps of data into 1 column
	idx = find(abs(data)>block);			% pts outside of threshold bound
%  	idx = repmat(idx,1,length(spacevec));	% create repeating columns
% 	if ~isempty(idx)
% 		spacemat = repmat(spacevec,size(idx,1),1);
% 		idx = idx + spacemat;				% add points to left and right of idx
% 		idx = unique(idx);					% remove redundant points
% 	end;
	idx = spaceout(idx,space);				% augments the index by +/- 'space' points
	keepidx = setdiff(1:M*N,idx);			% take only good points
	newdata = data(keepidx);					

% 3) Spike times to avoid %
else										% 'block' = spike times
	data = reshape(data,M*N,1);	
	idx = sub2ind([N M],block(2,:),block(1,:))';
%  	idx = repmat(idx,1,length(spacevec));
% 	if ~isempty(idx)
% 		spacemat = repmat(spacevec,size(idx,1),1);
% 		idx = idx + spacemat;
% 		idx = unique(idx);
% 	end;
	idx = spaceout(idx,space);
	keepidx = setdiff(1:M*N,idx);
	newdata = data(keepidx);
end;

stdout = std(newdata);						% find STD and mean of adjusted data trace
meanout = mean(newdata);

keepind = false(N,M);
keepind(keepidx) = true;
