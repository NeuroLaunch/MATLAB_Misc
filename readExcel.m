% READEXCEL.M
% function xlData = readExcel(xlfile,xlpage,xlInstruct)
%	Generic function to read in columns from an Excel spread sheet
% located in file 'xlfile' on page 'xlpage'. 'xlInstruct' is a
% structure with one element for each output in 'xlData'. The fields
% for each element (i.e. 'xlInstruct(1)','(2)',etc) are '.name',
% '.range' (e.g. 'D4:D15'), and '.length'; the last may be empty and
% is intended to force the output vector or array to fill with NaNs if
% the number of readable rows is less than the expected number.
%	Output comes in the form 'xlData.namex' = 'valuex', where '.namex'
% is the name string given in 'xlInstruct(x)' and 'valuex' is the
% corresponding vector or 2-D array read from the spread sheet.
%
% Revisions:
%	2015.10.23: Now using "raw" output form of XLSREAD, to improve handling
% of blank or 'NaN' entries (with MATLAB R2015). This simplifies the code greatly.
%

function xlData = readExcel(xlfile,xlpage,xlInstruct)

xlData = struct;

if ~isfield(xlInstruct,'length')
	[xlInstruct.length] = deal([]);
end;
if ~isfield(xlInstruct,'type')
	[xlInstruct.type] = deal('num');
end;

for i = 1:length(xlInstruct)
  xlrng = xlInstruct(i).range;
  xltype = xlInstruct(i).type;

  if ~isempty(xlrng)					% can't handle mixed right now
	[~,~,TempRaw] = xlsread(xlfile,xlpage,xlrng);

	if strcmp(xltype,'num')
		try
			warning off;
			output = cat(1,TempRaw{:});
			warning on;
		catch							% in case some extra text is added along the spreadsheet column
			for j = 1:size(TempRaw,1)
				if ~isnumeric(TempRaw{j}), TempRaw{j} = NaN; end;
			end;
			output = cat(1,TempRaw{:});
		end;
	else
		output = TempRaw;
	end;

	xlData.(xlInstruct(i).name) = output;

  else
	xlData.(xlInstruct(i).name) = [];

  end; % if ~isempty(xlrng)

end;
