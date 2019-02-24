% LOOKFORFILES.M
% function fileNames = lookforfiles(filedir,filtInclude,filtstart,filtext)
%

function fileNames = lookforfiles(filedir,filtInclude,filtstart,filtext)

% Interpret the inputs %
if ischar(filtInclude)
	filtInclude = {filtInclude};
end;
nFilt = length(filtInclude);

if isempty(filtext)
	filtext = '*.*';
elseif ~strcmp(filtext(1),'*')
	warning('Input argument ''filtext'' should start with "*" if it represents a trailing string.');
end;

% First get all the file names %
olddir = pwd; cd(filedir);
fileNamesAll = dir(filtext);
fileNamesAll = {fileNamesAll.name};

cd(olddir);
if isempty(fileNamesAll)
	fileNames = {''};
	return;
end;
nFiles = length(fileNamesAll);

% Then filter based on the start and include strings %
if ~isempty(filtstart)
	matchTemp = regexpi(fileNamesAll,filtstart);
	matchstart = false(1,nFiles);
	for i = 1:length(matchTemp)
		if ~isempty(matchTemp{i}) && matchTemp{i}(1)==1
			matchstart(i) = true;
		end;
	end;
else
	matchstart = true(1,nFiles);
end;

if nFilt
  MatchStart = false(nFilt,nFiles);
  for ff = 1:nFilt
	matchTemp = regexpi(fileNamesAll,filtInclude{ff});
	for i = 1:length(matchTemp)
		if matchTemp{i}>=1, MatchStart(ff,i) = true; end;
	end;
  end;
  matchinclude = all(MatchStart,1);
else
  matchinclude = true(1,nFiles);
end;

matchfilt = matchstart & matchinclude;

fileNames = fileNamesAll(matchfilt);

