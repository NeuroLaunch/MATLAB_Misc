% MAKE_VARARRAY.M
% function VarArray = make_vararray(var1, var2, etc...);
%	Transform multiple variables to an array of
% permutations of those variables. The input list
% can be one or more vectors, each vector containing
% the values of one variable; e.g. var1 = [0 30 60 90]
% for orientation (or possibly the index [1 2 3 4] if
% the actual values of the orientation are not relevant.)
% 	The output is an array of all permutations of the input
% vectors, based on the permutation model of the Matlab
% function NDGRID. The number of rows is equal to the number of
% input variables; the number of columns is equal to the
% product of the length of each input vector. Across the
% columns, the first row of 'VarArray' (variable #1) changes
% the most often, followed by the second row, etc. Hence, the
% column numbers match the condition index given by the often
% used command "GetConditionNumber(condlist)".
%	e.g.   var1 = [0 30 60 90]    var2 = [100 200]
%
%		VarArray = [  0   30  60  90  0   30  60  90
%		             100 100 100 100 200 200 200 200   ]
%

function VarArray = make_vararray(varargin)

Nvar = length(varargin);					% the number of variables

% Error check %
for n = 1:Nvar
	if min(size(varargin{n})) > 1
		error('Input is not a vector');
	end;
	if isempty(varargin{n})
		error('Input cannot be empty');
	end;
end;

% Get total number of values across all variables %
Nvalue = 1;									% the total number of variable elements
for n = 1:Nvar
	Nvalue = Nvalue*length(varargin{n});
end;

if Nvar == 1
	VarArray = varargin{1};					% trivial if only one variable ..
else
	condGrid = cell(1,Nvar);				% .. else get permutations of variables
	[condGrid{1:Nvar}] = ndgrid(varargin{1:Nvar});
	VarArray = zeros(Nvar,Nvalue);
	for n = 1:Nvar							% row  #1 is variable 1, etc
		vec = condGrid{n}(1:end);
		if size(vec,1)>1					% make sure it's not a column vector
			vec = vec';
		end;
		%VarArray(n,:) = condGrid{n}(1:end); % and column #1 is first condition number, etc
		VarArray(n,:) = vec;
	end;
end;