% READEXCEL.M
% function xlData = readExcel(xlfile,xlpage,xlInstruct)
%	Generic function to read in columns from an Excel spread sheet
% located in file 'xlfile' on page 'xlpage'. 'xlInstruct' is a
% structure with one element for each output in 'xlData'. The fields
% for each element (i.e. 'xlInstruct(1)','(2)',etc) are '.name',
% '.range' (e.g. 'D4:D15', and '.length'; the last may be empty and
% is intended to force the output vector or array to fill with NaNs if
% the number of readable rows is less than the expected number.
%	Output comes in the form 'xlData.namex' = 'valuex', where '.namex'
% is the name string given in 'xlInstruct(x)' and 'valuex' is the
% corresponding vector or 2-D array read from the spread sheet.
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

  if ~isempty(xlrng)
	xllength = xlInstruct(i).length;	% can't handle mixed right now
	[TempNum,TempTxt] = xlsread(xlfile,xlpage,xlrng);

	if isempty(TempTxt), TempTxt = {[]}; end;

	if strcmp(xltype,'num')				% important! catch leading 'NaN' or blank entry (#SMB 2015.07.10)
		if ~isempty(xllength) && ~isempty(TempNum) && size(TempNum,2)<xllength && ~isempty(TempTxt{1})
			TempRead = [NaN TempNum];	% this will cause an error for non-vector ranges (i.e. w/ rows AND columns)
		else
			TempRead = TempNum;
		end;
	else
		TempRead = TempTxt;
	end;
	flipped = false;

	if ~isempty(TempRead)
		val = TempRead;
		if size(val,2)>1 && size(val,1)==1
			val = val'; flipped = true;
		end;
		if ~isempty(xllength) && strcmp(xltype,'num')
			val((size(val,1)+1):xllength,:) = NaN;
		elseif ~isempty(xllength) 
			val((size(val,1)+1):xllength,:) = {NaN};
		end;
	else
		val = [];
	end;

	if flipped, val = val'; end;

	xlData.(xlInstruct(i).name) = val;
  else
	xlData.(xlInstruct(i).name) = [];
  end;

end;
