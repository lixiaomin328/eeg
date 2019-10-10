%% new replacement pipe
LoadingDir = '/Volumes/colin/cleanResampled';
SavingDir = '/Volumes/colin/tryNewPiple/';
%% settings for clean.m
arg_flatline = -1;
arg_highpass =-1;
arg_channel=0.8; 
arg_noisy=-1; 
arg_burst=8; 
arg_window=0.25; 
optionalInputCells=cell(0,0);
numberOfChans =64;
lineFreLow=60;
lineFreHigh = 120;
pValue=0.01;
tau = 100;
winsize = 4;
winstep = 1;

%% begin resample and stuff
for subId = 1:length(eegFiles)
filename = eegFiles(subId).name;
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
EEG = eeg_checkset(EEG);
EEG = pop_resample(EEG,256);
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:numberOfChans] ,'computepower',0,...
    'linefreqs',[lineFreLow lineFreHigh] ,'normSpectrum',0,'p',pValue,'pad',2,'plotfigures',0,'scanforlines',1,...
    'sigtype','Channels','tau',tau,'verb',1,'winsize',winsize,'winstep',winstep);
%% Update EEG.
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');
%% re-reference to average
%%
EEG = pop_saveset(EEG,'filename',filename,'filepath',SavingDir);
fprintf(['Done for ',num2str(subId)])
end