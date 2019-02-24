% TRYLOAD.M
% function loadStruct = tryload(filename,var1,var2,...)
%	Useful function that loads the specified variables ('var1',
% 'var2',etc) from the file specified by 'filename'. If no input
% arguments are given, all variables are loaded; otherwise, only
% matching variables are loaded. Wildcards (e.g. 'SReg*') are
% acceptable.
%	If no output argument is provided, the usual loading structure will
% be returned. Otherwise, the variables will be loaded in the calling
% workspace (like the usual LOAD command). The output is empty
% if no matching variables exist.
%

function loadStruct = tryload(filename,varargin)

for i = 1:nargin-1					% error check inputs
	str = varargin{i};
	if ~ischar(str) error('Variable arguments must be strings.'); end;
end;

lStruct = whos('-file',filename,varargin{:});
lNames = cell(1,length(lStruct));	% get chosen variables that exist
[lNames{:}] = deal(lStruct.name);	% (ALL variables if varargin is empty)

if length(lNames) > 0				% load to a structure
	loadStruct = load(filename,lNames{:});
else
	loadStruct = [];
end;
if ~nargout				% assign vars in workspace, else just return 'loadStruct'
	for i = 1:length(lNames)
		value = getfield(loadStruct,lNames{i});
		assignin('caller',lNames{i},value);
	end;
end;