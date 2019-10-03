# MATLAB General Utility Functions
A collection of useful MATLAB routines I've written and collected over the years, many called by programs in other repositories. The code can easily be translated to the Python _numpy_ module (keeping in mind that MATLAB indexing starts at 1).

M-file | Description / Example
------ | -----------
[getclosest](getclosest.m) | Find the closest elements, by absolute value, of one vector to another; returns an index
&nbsp; | _actual = [0 10 20 30 40 50]; desired = [-2 0 9 11 24 26 165]; output = [1 1 2 2 3 4 6]_
[spaceout](spaceout.m) | Expand vector of integers (such as representing an index) or booleans forward and backwards by integer 'space'
&nbsp; | _input = [34 35 36 90]; space = 2; output = [32 33 34 35 36 37 38 88 89 90 91 92]_
[cleanmean](cleanmean.m) | Calculate the mean and std of a vector or array, excluding values outside a set range
&nbsp; | 
[getstd](getstd.m) | Get std. deviation of an array, excluding points defined by an index (invoking _spaceout.m_)
&nbsp; | 
[readExcel](readExcel.m) | Generic function to read in columns from an Excel spread sheet
&nbsp; | 
[lookforfiles](lookforfiles.m) | Get the name of all files from a directory matching a desired pattern
&nbsp; | 
[compare_structures](compare_structures.m) | Determine whether two structures have matching fields containing identical values
&nbsp; | 
[struct2array](struct2array.m) | Combine N-length numeric values from a field in an M-length structure to a single M\*N array
&nbsp; | 
[zerocell](zerocell.m) | Create an M-dimensional cell array that contains N-dimensional all-zero matrices
&nbsp; | 
[augmatrix](struct2array.m) | Extend the rows of a square matrix using linear interpolation or simple mirroring around the diagonal pivot
&nbsp; | 
[draggable](draggable.m) | Third-party function to allow graphic objects to be dragged; I added a callback routine, now available in a more on the Mathworks File Exchange, to facilitate the manual creation of boxes around data points in a scatter plot (e.g. for semi-supervised classification of neural spike waveforms)
&nbsp; | 
[findjobj](findjobj.m) | Third-party function to find a java object within a Matlab graphics object, specified by its handle
&nbsp; | 
[sgfilter](sgfilter.m) | Third-party function to implement a smoothing FIR filter via local least-squares fitting
&nbsp; | 
[xticklabel_rotate](xticklabel_rotate.m) | Third-party function to easily rotate x-axis labels by a specified number of degrees
&nbsp; | 
[readExcel](readExcel.m) | Read columns from an Excel spread sheet from a specified page using instructions for column/row ranges; output is a 1x1 structure, with a different field for each output vector or 2-D matrix
&nbsp; | 
[tryload](tryload.m) | Load specific variables (wildcard "\*" accepted) into a structure or workspace
&nbsp; | 
[make_vararray](make_vararray.m) | Transform scalars or vectors to an array of permutations of their elements, using the MATLAB function NDGRID
&nbsp; | _var1 = [ 0 30 60 90 ],  var2 = [ 100 200 ];  output = [ 0   30  60  90  0   30  60  90 ; 100 100 100 100 200 200 200 200 ]_
[useful](useful.m) | A random assortment of code snippets I've found useful for reference
&nbsp; | 
