# MATLAB General Utility Functions
A collection of useful MATLAB routines I've written and collected over the years, many invoked by programs in other repositories. The code can easily be translated to the Python _numpy_ module (keeping in mind that MATLAB indexing starts at 1).

M-file | Description / Example
------ | -----------
[getclosest](getclosest.m) | Find the closest elements, by absolute value, of one vector to another; returns an index
&nbsp; | actual = [0 10 20 30 40 50]; desired = [-2 0 9 11 24 26 165]; output = [1 1 2 2 3 4 6]
[spaceout](spaceout.m) | Expand vector of integers (such as representing an index) or booleans forward and backwards by integer 'space'
&nbsp; | input = [34 35 36 90]; space = 2; output = [32 33 34 35 36 37 38 88 89 90 91 92]
[readExcel](readExcel.m) | Generic function to read in columns from an Excel spread sheet
&nbsp; | 
[cleanmean](cleanmean.m) | Calculate the mean and std of a vector or array, excluding points outside a set range
&nbsp; |
[compare_structures](compare_structures.m) | Determine whether two structures, S1 and S2, have matching fields containing identical values


