% CLEANMEAN.M
% function [meanout,stdout,NaNind] = cleanmean(X,dim,stdlvl,space)
%	Calculate the mean and std of a vector or 2-D array 'X' along
% the dimension 'dim', excluding points outside of a +/- criterion
% level. That level is specified as the intial standard deviation
% along 'dim' times the scalar input 'stdlvl'. The optional argument
% 'space' specifies the number of points to also exclude on either side
% of the std-excluded points, along the OTHER dimension.
%	Outputs are the mean and standard deviation, after excluding
% outlying points, as well as an array 'NaNind' that is the same
% size as 'X' and contains a logical 1 for all excluded points.
%
% Written by Steven M. Bierer, 05/14/2010.
%

function [meanout,stdout,NaNind] = cleanmean(X,dim,stdlvl,space)


if dim>2, error('Maximum allowable array dimension is 2.'); end;
if dim>ndims(X), error('Dimension parameter is larger than the array.'); end;

if nargin<4, space = 0; end;
if mod(dim,1) || mod(space,1)
	error('Non-integer argument is not allowed.');
end;

meantemp = mean(X,dim);		% derive preliminary average
stdtemp = std(X,0,dim);

if dim==2					% find points outside the std criterion level
	Err = X - repmat(meantemp,[1 size(X,2)]);
	NaNind = abs(Err) > stdlvl * repmat(stdtemp,[1 size(X,2)]);
else
	Err = X - repmat(meantemp,[size(X,1) 1]);
	NaNind = abs(Err) > stdlvl * repmat(stdtemp,[size(X,1) 1]);
end;

if space && dim==2			% augment the NaN extent by +/- 'space'
	npts = size(X,2);
	NaNind_aug = cat(1,zeros(space,npts),NaNind,zeros(space,npts));
	for shift = [-space:space]
		NaNind = or( NaNind, NaNind_aug(space+1+shift:end-space+shift,:) );
	end;
elseif space
	npts = size(X,1);
	NaNind_aug = cat(2,zeros(npts,space),NaNind,zeros(npts,space));
	for shift = [-space:space]
		NaNind = or( NaNind, NaNind_aug(:,space+1+shift:end-space+shift) );
	end;
end;

X(NaNind) = NaN;			% exclude the outliers and re-average
meanout = nanmean(X,dim);
stdout = nanstd(X,0,dim);