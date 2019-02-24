% Useful code snippets.
%

% new way to pre-define object handles %
hvector = gobjects(1,5);

% find handle of a hidden figure %
h = findall(0,'type','figure');

% e.g. of creating a legend for representative subset of data %
h = plot(XPlot(bidx,aplidx),YPLot(bidx,aplidx),'ro'); hset(1) = h(1); lgdStr{1} = 'apical';
legend(hset,lgdStr);

% see if a figure has a pending UIWAIT %
stat = get( fighandle, 'waitstatus' );	% output is 'waiting' or 'inactive'

% strange effect on x-axis when using zoom tool? %
set(gca,'XTickLabelMode','auto');		% e.g. happens when adding text to figure

% place values from a field in a structure array into a cell array %
outcell = cat(2,{Struct.field});		% or...
outcell = {Struct.field};

% basic time vector %
maxtime = (nPts-1)/smplrate * 1000;		% determine time vector (in msec)
time = linspace(0,maxtime,nPts);

% Code to find which radio button is on (but should use button groups!) %
hradio = findobj('Style','RadioButton');		% find which radio button is ON
radio_idx = find(get(hradio,'Value'));
hradio = hradio(radio_idx{1});
radio_string = get(hradio,'Tag');				% the "tag" of the ON radio button


% get filters into workspace from SPTOOL %
[filt_b,filt_a] = filtdes('getfilt');

% Allow MATLAB to work as a COM server %
h = actxserver('Matlab.Application');			% try this first ..
% h = COM.Matlab_Application
% !matlab /regserver							% .. and this if that fails


% Sine wave demo %

% Choose the parameters %
freq1 = 100;		% freq in Hz
phase1 = 0;			% + for advance, - for lag
freq2 = 100;
phase2 = 45;

% Define waveforms %
time = 0:.0001:.04; time_ms = time*1000;
wave1 = cos(2*pi*freq1*time + pi/180*phase1);
wave2 = cos(2*pi*freq2*time + pi/180*phase2);

% Plot waveforms %
figure;
subplot(2,1,1);
plot(time_ms,wave1,time_ms,wave2);
yrngA = ylim;
subplot(2,1,2);
plot(time_ms,wave1+wave2,'r');
yrngB = ylim;

ymin = min([yrngA yrngB]);
ymax = max([yrngA yrngB]);
subplot(2,1,1); ylim([ymin ymax]);
ylabel('Magnitude');
legend('Wave1','Wave2');

subplot(2,1,2); ylim([ymin ymax]);
ylabel('Magnitude'); xlabel('Time (ms)');
legend('Sum');



% Example of changing the order of an object's CHILDREN %
%hL = findobj(fig,'type','axes');			% determine the handles of the "label" axes
%hL = hL(strncmp('label',get(hL,'tag'),5));
%hL = [handles.blocking_axes ; hL];			% add lower-bound axes (frame): a just-lower priority

%chlist = get(fig,'Children');
%[hNew,labelidx] = intersect(chlist,hL);
%skiplist = setdiff(1:length(chlist),labelidx);
%chlist_new = [chlist(skiplist) ; hNew];		% re-order the figure's children list

%set(fig,'Children',chlist_new);				% (ordering forces axes to plot underneath labels)


%%%% For Leo: synthesizing spike waveforms from a spike train array %%%%
% Define some necessary constants %
peakpt = sortInfo.detection.peakpt;
nPts = sortInfo.detection.nPts;
a_ex = peakpt - 1; b_ex = nPts - peakpt;

% Synthesize a whole data trace by adding spikes to a zero baseline %
synthSet{1} = spsynth(size(traceSet{1}),SpTrain,Template,peakpt);
residSet{1} = traceSet{1} - synthSet{1};

% Some interesting extractions %
exOrig{1} = spextract(SpTrain,traceSet{1},a_ex,b_ex);
exSynth{1} = spextract(SpTrain,synthSet{1},a_ex,b_ex);
exResid{1} = spextract(SpTrain,residSet{1},a_ex,b_ex);

% Focusing on one spike of interest, 'sp', strip it of all overlaps %
sp = 110;
justoneSet{1} = spsynth(size(traceSet{1}),SpTrain(:,sp),Template,peakpt);
exjustone = spextract(SpTrain(:,sp),justoneSet{1},a_ex,b_ex);

% Plot that one example %
excleanone = exOrig{1}(:,sp) - exSynth{1}(:,sp) + exjustone;
plotex(exOrig,sp);
plotex(excleanone);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%